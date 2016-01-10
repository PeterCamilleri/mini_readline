# coding: utf-8

require_relative 'windows/win_32_api'
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
      @_getch = Win32API.new("msvcrt", "_getch", [])
      @_kbhit = Win32API.new("msvcrt", "_kbhit", [])
      @_beep  = Win32API.new("user32", "MessageBeep", ['L'])

      @_set_cursor_posn = Win32API.new("kernel32",
                                       "SetConsoleCursorPosition",
                                       ['L','L'])

      @_get_screen_info = Win32API.new("kernel32",
                                       "GetConsoleScreenBufferInfo",
                                       ['L','P'])

      @_get_handle = Win32API.new("kernel32", "GetStdHandle", ['L'])
    end

    #Output a string
    def put_string(str)
      print(str)
    end

    #Home the cursor and start at a known state.
    def initialize_parms
      @_out_handle = @_get_handle.call(STD_OUTPUT_HANDLE)
      put_string CARRIAGE_RETURN
    end

    #Sound a beep
    def beep
      @_beep.call(0)
    end

    #Wait for a key to be pressed.
    def wait_for_key
      while (@_kbhit.call == 0)
        sleep(WAIT_SLEEP)
      end
    end

    #Get a uncooked character keystroke.
    def get_raw_char
      wait_for_key
      @_getch.call.chr
    end
  end
end
