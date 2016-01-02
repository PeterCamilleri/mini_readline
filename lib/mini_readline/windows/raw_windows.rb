# coding: utf-8

require_relative 'win_32_api'
require_relative 'map_windows'
require_relative 'set_posn'

#* windows/raw_windows.rb - Support for raw terminal access in windows systems.
module MiniReadline

  #The detected platform is windows.
  PLATFORM = :windows

  #The class used to manipulate console i/o on a low level.
  class RawTerm

    #The sleep interval waiting for a key to be pressed.
    WAIT_SLEEP      = 0.02

    #Carriage return
    CARRIAGE_RETURN = "\x0D"

    #Backspace
    BACK_SPACE      = "\x08"

    #The magic number for standard out.
    STD_OUTPUT_HANDLE = -11

    #Set up the Windows Raw Terminal.
    def initialize
      @_getch = Win32API.new("msvcrt", "_getch", [], 'I')
      @_kbhit = Win32API.new("msvcrt", "_kbhit", [], 'I')
      @_beep  = Win32API.new("user32", "MessageBeep", ['L'], 'L')

      @_set_cursor_posn = Win32API.new("kernel32",
                                       "SetConsoleCursorPosition",
                                       ['L','L'], 'L')

      @_get_screen_info = Win32API.new("kernel32",
                                       "GetConsoleScreenBufferInfo",
                                       ['L','P'], 'L')

      @_get_handle = Win32API.new("kernel32", "GetStdHandle",['L'], 'L')
      @_out_handle = @_get_handle.call(STD_OUTPUT_HANDLE)
    end

    #Output a string
    def put_string(str)
      scan_string(str) unless @_out_handle
      print(str)
    end

    #Home the cursor and start at a known state.
    def reset
      put_string CARRIAGE_RETURN
    end

    #Back up the cursor
    def back_up(count)
      put_string BACK_SPACE * count
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

    #Determine the affect of a string on the cursor.
    def scan_string(str)
      str.chars.each do |char|
        case char
        when CARRIAGE_RETURN
          @cursor_posn = 0
        when BACK_SPACE
          @cursor_posn -= 1
        else
          @cursor_posn += 1
        end
      end
    end

  end

end
