# coding: utf-8

#* windows/set_posn.rb - Set the column of the cursor.
module MiniReadline

  #* windows/set_posn.rb - Set the column of the cursor.
  class RawTerm

    #Set the position of the screen cursor within the line.
    def set_posn(new_posn, buffer)
      if @_out_handle
        api_set_posn(new_posn)
      else
        term_set_posn(new_posn, buffer)
      end
    end

    private

    #Move the cursor using windows voodoo API.
    def api_set_posn(new_posn)
      raw_buffer = 0.chr * 24
      @_get_screen_info.call(@_out_handle, raw_buffer)
      y_posn = (raw_buffer[6,2].unpack('S'))[0]

      @_set_cursor_posn.call(@_out_handle, y_posn * 65536 + new_posn)
    end

    #Move the cursor using laborious terminal primitives.
    def term_set_posn(new_posn, buffer)
      if new_posn == 0
        reset
      else
        move_cursor(new_posn, @cursor_posn, buffer) if new_posn != @cursor_posn
      end
    end

    #Move the cursor from the old_posn to the new_posn.
    def move_cursor(new_posn, old_posn, buffer)
      gap = old_posn - new_posn

      if new_posn > old_posn
        put_string(buffer[old_posn...new_posn])
      elsif gap > (old_posn / 2)
        reset
        move_cursor(new_posn, 0, buffer)
      else
        put_string(RawTerm::BACK_SPACE*(gap))
      end
    end
  end
end
