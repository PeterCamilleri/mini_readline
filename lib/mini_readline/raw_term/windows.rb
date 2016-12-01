# coding: utf-8

if MiniReadline::TERM_JAVA
  require 'win32api'
else
  require_relative 'windows/win_32_api'
end

require_relative 'mapped_term'
require_relative 'windows/map'
require_relative 'windows/set_posn'
require_relative 'windows/window_width'

#* raw_term/windows.rb - Support for raw terminal access in windows systems.
module MiniReadline

  #The detected platform is windows.
  PLATFORM = :windows

  #The class used to manipulate console i/o on a low level.
  class RawTerm

    #The sleep interval waiting for a key to be pressed.
    WAIT_SLEEP      = 0.02

    #Carriage return
    CARRIAGE_RETURN = "\x0D"

    #The magic number for standard out.
    STD_OUTPUT_HANDLE = -11

    #Set up the Windows Raw Terminal.
    #<br>Singleton Methods Added:
    #* getch - Low-level get char.
    #* kbhit - Low-level keyboard hit test.
    #* beep - Low-level beep.
    #* set_cursor_posn - Set the cursor position given coordinates (y*65536+x).
    #* get_screen_info - Get info about the console.
    #* get_handle - Get the internal handle associated with a file index.
    def initialize
      getch_proc = Win32API.new("msvcrt", "_getch", [], 'I')
      define_singleton_method(:getch) { getch_proc.call.chr }

      kbhit_proc = Win32API.new("msvcrt", "_kbhit", [], 'I')
      define_singleton_method(:kbhit) { kbhit_proc.call }

      beep_proc  = Win32API.new("user32", "MessageBeep", ['L'], '0')
      define_singleton_method(:beep) { beep_proc.call }

      set_cursor_posn_proc = Win32API.new("kernel32",
                                          "SetConsoleCursorPosition",
                                          ['L','L'], 'L')

      define_singleton_method(:set_cursor_posn) do |position|
        set_cursor_posn_proc.call(@_out_handle, position)
      end

      get_screen_info_proc = Win32API.new("kernel32",
                                          "GetConsoleScreenBufferInfo",
                                          ['L','P'], 'L')

      define_singleton_method(:get_screen_info) do |buffer|
        get_screen_info_proc.call(@_out_handle, buffer)
      end

      get_handle_proc = Win32API.new("kernel32", "GetStdHandle", ['L'], 'L')

      define_singleton_method(:get_handle) do |handle_index|
        get_handle_proc.call(handle_index)
      end

    end

    #Output a string
    #<br>Endemic Code Smells
    #* :reek:UtilityFunction
    def put_string(str)
      STDOUT.print(str)
    end

    #Home the cursor and start at a known state.
    def initialize_parms
      @_out_handle = get_handle(STD_OUTPUT_HANDLE)
      put_string(CARRIAGE_RETURN)
    end

    #Conclude the terminal state.
    def conclude
      put_string("\n")
    end

    #Get a uncooked character keystroke.
    def get_raw_char
      while (kbhit == 0)
        sleep(WAIT_SLEEP)
      end

      getch
    end
  end
end
