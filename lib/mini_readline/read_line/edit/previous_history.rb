# coding: utf-8

#* read_line/window/edit/previous_history.rb - Process :previous_history
module MiniReadline

  #* read_line/window/edit/previous_history.rb - Process :previous_history
  class Edit

    #The insert_text command. We are DONE!
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
