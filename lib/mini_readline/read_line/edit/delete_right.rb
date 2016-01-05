# coding: utf-8

#* read_line/window/edit/delete_right.rb - Process :delete_right
module MiniReadline

  #* read_line/window/edit/delete_right.rb - Process :delete_right
  class Edit

    #The delete to the right
    def delete_right(_keyboard_args)
      if @edit_posn < self.length
        @edit_buffer = @edit_buffer[0...(@edit_posn)] +
                       @edit_buffer[@edit_posn+1..-1]
      else
        @term.beep
      end
    end
  end
end
