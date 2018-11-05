# coding: utf-8

# Process :word_left
module MiniReadline

  # Process :word_left
  class Edit

    # A little more to the left please!
    def word_left(_keyboard_args)
      if @edit_posn > 0
        left = @edit_buffer[0...@edit_posn]
        @edit_posn = (posn = left.rindex(/\s\S/)) ? posn+1 : 0
      else
        MiniTerm.beep
      end
    end
  end
end
