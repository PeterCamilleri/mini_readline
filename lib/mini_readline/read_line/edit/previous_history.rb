# coding: utf-8

# Process :previous_history
module MiniReadline

  # Process :previous_history
  class Edit

    # The insert_text command. We are DONE!
    def previous_history(_keyboard_args)
      if (temp = @history.get_previous_history)
        @edit_buffer = temp
        @edit_posn   = temp.length
      else
        MiniTerm.beep
      end
    end
  end
end
