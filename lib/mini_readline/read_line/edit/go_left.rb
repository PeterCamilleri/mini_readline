# coding: utf-8

# Process :go_left
module MiniReadline

  # Process :go_left
  class Edit

    #A little to the left please!
    def go_left(_keyboard_args)
      if @edit_posn > 0
        @edit_posn -= 1
      else
        MiniTerm.beep
      end
    end
  end
end
