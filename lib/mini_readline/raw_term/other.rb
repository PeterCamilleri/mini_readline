# coding: utf-8

require          'io/console'
require_relative 'other/map'
require_relative 'other/set_posn'

#* raw_term/other.rb - Support for raw terminal access in non-windows systems.
module MiniReadline

  #The detected platform is not windows.
  PLATFORM = :other

  #The class used to manipulate console i/o on a low level.
  class RawTerm

    #The sleep interval waiting for a key to be pressed.
    WAIT_SLEEP      = 0.02

    #Carriage return
    CARRIAGE_RETURN = "\x0D"

    #Backspace
    BACK_SPACE      = "\x08"

    #Bell
    BELL            = "\x07"

    #Set up the Other Raw Terminal.
    def initialize
    end

    #Output a string
    def put_string(str)
      scan_string(str)
      print(str)
    end

    #Home the cursor and start at a known state.
    def initialize_parms
      put_string CARRIAGE_RETURN
    end

    #Start on a new line.
    def put_new_line
      print("\n")
    end

    #Back up the cursor
    def back_up(count)
      put_string BACK_SPACE * count
    end

    #Sound a beep
    def beep
      print BELL
    end

    #Get a uncooked character keystroke.
    def get_raw_char
      STDIN.getch
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
