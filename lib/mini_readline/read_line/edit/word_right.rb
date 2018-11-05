# coding: utf-8

# Process :word_right
module MiniReadline

  # Process :word_right
  class Edit

    #A little more to the right please!
    def word_right(_keyboard_args)
      if @edit_posn < length
        right = @edit_buffer[(@edit_posn+1)..-1]
        @edit_posn = (posn = right.index(/\s\S/)) ? @edit_posn+posn+2 : length
      else
        MiniTerm.beep
      end
    end
  end
end
