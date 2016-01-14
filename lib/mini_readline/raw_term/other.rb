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

    #Carriage return
    CARRIAGE_RETURN = "\x0D"

    #Bell
    BELL = "\x07"

    #Output a string
    def put_string(str)
      scan_string(str)
      print(str)
    end

    #Home the cursor and start at a known state.
    def initialize_parms
      put_string CARRIAGE_RETURN
      STDIN.raw!
    end

    #Conclude the terminal state.
    def conclude
      STDIN.cooked!
      print("\n")
    end

    #Sound a beep
    def beep
      $stderr.write(BELL)
      $stderr.flush
    end

    #Get a uncooked character keystroke.
    #<br>Notes
    #* This needs to be tested under Linux, Cygwin, and Apple.
    #<br>Endemic Code Smells
    #* :reek:UtilityFunction -- For now, the way things are.
    def get_raw_char
      STDIN.getch
    end

    #Determine the affect of a string on the cursor.
    def scan_string(str)
      str.chars.each do |char|
        if char == CARRIAGE_RETURN
          @cursor_posn = 0
        else
          @cursor_posn += 1
        end
      end
    end
  end
end
