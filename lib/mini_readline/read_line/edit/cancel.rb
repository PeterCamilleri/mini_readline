# coding: utf-8

# Process :cancel
module MiniReadline

  # Process :cancel - delete all text.
  class Edit

    # All right! Scrap all of this and start over!
    def cancel(_keyboard_args)
      @edit_buffer = ""
      @edit_posn = 0
    end
  end
end
