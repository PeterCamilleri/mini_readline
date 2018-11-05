# coding: utf-8

# Process :delete_left
module MiniReadline

  # Process :delete_all_left
  class Edit

    #The delete to the left command
    def delete_all_left(_keyboard_args)
      if @edit_posn > 0
        @edit_buffer = @edit_buffer[@edit_posn..-1]
        @edit_posn = 0
      else
        MiniTerm.beep
      end
    end
  end
end
