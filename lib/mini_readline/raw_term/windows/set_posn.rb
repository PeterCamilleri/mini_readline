# coding: utf-8

#* windows/set_posn.rb - Set the column of the cursor.
module MiniReadline

  #* windows/set_posn.rb - Set the column of the cursor.
  class RawTerm

    #Set the position of the screen cursor within the line.
    def set_posn(new_posn)
      if @_out_handle
        api_set_posn(new_posn)
      else
        term_set_posn(new_posn)
      end
    end

    #Move the cursor using windows voodoo API.
    def api_set_posn(new_posn)
      raw_buffer = 0.chr * 24
      @_get_screen_info.call(@_out_handle, raw_buffer)
      y_posn = (raw_buffer[6,2].unpack('S'))[0]

      @_set_cursor_posn.call(@_out_handle, y_posn * 65536 + new_posn)
    end

    #Move the cursor using terminal primitives.
    def term_set_posn(new_posn)

      if new_posn > @cursor_posn
        print("\e#{new_posn - @cursor_posn}C")
      elsif new_posn < @cursor_posn
        print("\e#{@cursor_posn - new_posn}D")
      end

      @cursor_posn = new_posn
    end

  end
end
