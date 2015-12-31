# coding: utf-8

#* read_line/window/set_posn.rb - Update the screen cursor position
module MiniReadline

  #* read_line/window/set_posn.rb - Update the screen cursor position
  class Readline

    private

    #Set the position of the screen cursor within the line.
    def set_posn(new_posn)
      if new_posn == 0
        @term.reset
      else
        old_posn = @term.cursor_posn
        move_cursor(new_posn, old_posn) if new_posn != old_posn
      end
    end

    #Move the cursor from the old_posn to the new_posn.
    def move_cursor(new_posn, old_posn)
      if new_posn > old_posn
        @term.put_string(window_buffer[old_posn...new_posn])
      else
        @term.put_string(RawTerm::BACK_SPACE*(old_posn-new_posn))
      end
    end


  end
end