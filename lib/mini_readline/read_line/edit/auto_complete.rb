# coding: utf-8

#* read_line/window/edit/auto_complete.rb - Process :auto_complete
module MiniReadline

  #* read_line/window/edit/auto_complete.rb - Process :auto_complete
  class Edit

    #The insert_text command. We are DONE!
    def auto_complete(_keyboard_args)
      @term.beep
    end
  end
end
