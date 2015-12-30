# coding: utf-8

#* read_line/edit.rb - The line editor.
module MiniReadline

  #* read_line/edit.rb - The line editor.
  class Readline

    private

    #Determine the initial edit settings.
    def setup_edit_parms(string)
      @edit_posn, @edit_buffer = string.length, string.dup
    end

    #The main edit buffer
    attr_accessor :edit_buffer

    #The current edit position
    attr_accessor :edit_posn

    #How long is the current string?
    def length
      edit_buffer.length
    end

  end


end
