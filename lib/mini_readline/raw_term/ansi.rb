# coding: utf-8

require          'io/console'

require_relative 'mapped_term'
require_relative 'ansi/map'
require_relative 'ansi/set_posn'
require_relative 'ansi/window_width'

#* raw_term/ansi.rb - Support for raw terminal access in non-windows systems.
module MiniReadline

  #The detected platform is not windows.
  PLATFORM = :ansi

  #The class used to manipulate console i/o on a low level.
  class RawTerm

    CARRIAGE_RETURN = "\x0D"
    BELL = "\x07"

    #Output a string
    def put_string(str)
      scan_string(str)
      STDOUT.print(str)
    end

    #Home the cursor and start at a known state.
    def initialize_parms
      put_string CARRIAGE_RETURN
      STDIN.raw!
    end

    #Conclude the terminal state.
    #<br>Endemic Code Smells
    #* :reek:UtilityFunction
    def conclude
      STDIN.cooked!
      STDOUT.print("\n")
    end

    #Sound a beep
    #<br>Endemic Code Smells
    #* :reek:UtilityFunction
    def beep
      STDERR.write(BELL)
      STDERR.flush
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
