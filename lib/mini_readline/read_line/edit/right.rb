# coding: utf-8

#* read_line/window/edit/right.rb - Process :right
module MiniReadline

  #* read_line/window/edit/right.rb - Process :right
  class Readline

    #A little to the right please!
    def right(_keyboard_args)
      if @edit_posn < edit_buffer.length
        @edit_posn += 1
      else
        @term.beep
      end
    end
  end
end
