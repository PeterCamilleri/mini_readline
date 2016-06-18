# coding: utf-8

#* read_line/window/edit/enter.rb - Process :enter
module MiniReadline

  #* read_line/window/edit/enter.rb - Process :enter
  class Edit

    #The insert_text command. We are DONE!
    def enter(_keyboard_args)
      @edit_buffer << "\n"
      @working = false
    end
  end
end
