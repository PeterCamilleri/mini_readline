# coding: utf-8

#* windows/set_posn.rb - Set the column of the cursor.
module MiniReadline

  #* windows/set_posn.rb - Set the column of the cursor.
  class RawTerm

    #Move the cursor using terminal primitives.
    def set_posn(new_posn)

      if new_posn > @cursor_posn
        print("\e#{new_posn - @cursor_posn}C")
      elsif new_posn < @cursor_posn
        print("\e#{@cursor_posn - new_posn}D")
      end

      @cursor_posn = new_posn
    end
  end
end
