# coding: utf-8

#* read_line/window/edit/go_home.rb - Process :go_home
module MiniReadline

  #* read_line/window/edit/go_home.rb - Process :go_home
  class Edit

    #A lot to the left please!
    def go_home(_keyboard_args)
      @edit_posn = 0
    end
  end
end
