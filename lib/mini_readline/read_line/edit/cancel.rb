# coding: utf-8

#* read_line/window/edit/cancel.rb - Process :cancel
module MiniReadline

  #* read_line/window/edit/cancel.rb - Process :cancel
  class Readline

    #All right! Scrap all of this and start over!
    def cancel(_keyboard_args)
      @edit_buffer = ""
      @edit_posn = 0
    end

  end

end