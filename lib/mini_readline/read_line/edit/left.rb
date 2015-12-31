# coding: utf-8

#* read_line/window/edit/left.rb - Process :left
module MiniReadline

  #* read_line/window/edit/enter.rb - Process :left
  class Readline

    private

    #A little to the left please!
    def left(_keyboard_args)
      if @edit_posn > 0
        @edit_posn -= 1
      else
        @term.beep
      end
    end

  end

end