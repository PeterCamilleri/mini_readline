# coding: utf-8

#* read_line/window/edit/next_history.rb - Process :next_history
module MiniReadline

  #* read_line/window/edit/next_history.rb - Process :next_history
  class Edit

    #The insert_text command. We are DONE!
    def next_history(_keyboard_args)
      if (temp = @history.get_next_history)
        @edit_buffer = temp
        @edit_posn   = temp.length
      else
        MiniTerm.beep
      end
    end
  end
end
