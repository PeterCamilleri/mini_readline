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
  #<br>Endemic Code Smells
  # :reek:TooManyInstanceVariables
  class RawTerm

    #The sleep interval waiting for a key to be pressed.
    WAIT_SLEEP      = 0.02

    #Carriage return
    CARRIAGE_RETURN = "\x0D"

    #The magic number for standard out.
    STD_OUTPUT_HANDLE = -11

    #Set up the Windows Raw Terminal.
    def initialize
      @_getch = Win32API.new("msvcrt", "_getch", [], 'I')
      @_kbhit = Win32API.new("msvcrt", "_kbhit", [], 'I')
      @_beep  = Win32API.new("user32", "MessageBeep", ['L'], '0')
      @_set_cursor_posn = Win32API.new("kernel32", "SetConsoleCursorPosition",
                                       ['L','L'], 'L')
      @_get_screen_info = Win32API.new("kernel32", "GetConsoleScreenBufferInfo",
                                       ['L','P'], 'L')
      @_get_handle = Win32API.new("kernel32", "GetStdHandle", ['L'], 'L')
    end

    #Output a string
    def put_string(str)
      STDOUT.print(str)
    end

    #Home the cursor and start at a known state.
    def initialize_parms
      @_out_handle = @_get_handle.call(STD_OUTPUT_HANDLE)
      put_string CARRIAGE_RETURN
    end

    #Conclude the terminal state.
    def conclude
      STDOUT.print("\n")
    end

    #Sound a beep
    def beep
      @_beep.call(0)
    end

    #Get a uncooked character keystroke.
    def get_raw_char
      while (@_kbhit.call == 0)
        sleep(WAIT_SLEEP)
      end

      @_getch.call.chr
    end
  end
end
