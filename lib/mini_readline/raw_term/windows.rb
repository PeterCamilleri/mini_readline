# coding: utf-8

if MiniReadline::TERM_JAVA
  require 'win32api'
else
  require_relative 'windows/win_32_api'
end

require_relative 'mapped_term'
require_relative 'windows/map'
require_relative 'windows/set_posn'

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
    def initialize
      getch_proc = Win32API.new("msvcrt", "_getch", [], 'I')

      define_singleton_method(:getch) do
        getch_proc.call.chr
      end

      kbhit_proc = Win32API.new("msvcrt", "_kbhit", [], 'I')

      define_singleton_method(:kbhit) do
        kbhit_proc.call
      end

      beep_proc  = Win32API.new("user32", "MessageBeep", ['L'], '0')

      define_singleton_method(:beep) do
        beep_proc.call
      end

      set_cursor_posn_proc = Win32API.new("kernel32",
                                          "SetConsoleCursorPosition",
                                          ['L','L'], 'L')

      define_singleton_method(:set_cursor_posn) do |handle, position|
        set_cursor_posn_proc.call(handle, position)
      end

      get_screen_info_proc = Win32API.new("kernel32",
                                          "GetConsoleScreenBufferInfo",
                                          ['L','P'], 'L')

      define_singleton_method(:get_screen_info) do |handle, buffer|
        get_screen_info_proc.call(handle, buffer)
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
