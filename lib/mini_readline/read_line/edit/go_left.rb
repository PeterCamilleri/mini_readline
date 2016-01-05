# coding: utf-8

#* read_line/window/edit/go_left.rb - Process :go_left
module MiniReadline

  #* read_line/window/edit/go_left.rb - Process :go_left
  class Edit

    #A little to the left please!
    def go_left(_keyboard_args)
      if @edit_posn > 0
        @edit_posn -= 1
      else
        @term.beep
      end
    end
  end
end
