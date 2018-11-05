# coding: utf-8

# Process :go_right
module MiniReadline

  # Process :go_right
  class Edit

    # A little to the right please!
    def go_right(_keyboard_args)
      if @edit_posn < edit_buffer.length
        @edit_posn += 1
      else
        MiniTerm.beep
      end
    end
  end
end
