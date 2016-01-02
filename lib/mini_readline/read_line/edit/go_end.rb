# coding: utf-8

#* read_line/window/edit/go_home.rb - Process :go_end
module MiniReadline

  #* read_line/window/edit/go_home.rb - Process :go_end
  class Readline

    #A lot to the left please!
    def go_end(_keyboard_args)
      @edit_posn = length
    end

  end

end