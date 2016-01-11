# coding: utf-8

#* read_line/window/edit/word_left.rb - Process :word_left
module MiniReadline

  #* read_line/window/edit/word_left.rb - Process :word_left
  class Edit

    #A little more to the left please!
    def word_left(_keyboard_args)
      if @edit_posn > 0
        posn =  @edit_buffer[0...@edit_posn].rstrip.rindex(' ')
        @edit_posn = posn ? posn + 1 : 0
      else
        @term.beep
      end
    end
  end
end
