# coding: utf-8

#* read_line/window/edit/delete_left.rb - Process :delete_left
module MiniReadline

  #* read_line/window/edit/delete_left.rb - Process :delete_left
  class Readline

    private

    #The insert_text command
    def delete_left(_keyboard_args)
      if @edit_posn > 0
        @edit_buffer = @edit_buffer[0...(@edit_posn-1)] +
                       @edit_buffer[@edit_posn..-1]

        @edit_posn -= 1
      else
        @term.beep
      end
    end

  end

end