# coding: utf-8

#* read_line/window/edit/delete_left.rb - Process :delete_left
module MiniReadline

  #* read_line/window/edit/delete_all_left.rb - Process :delete_all_left
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
