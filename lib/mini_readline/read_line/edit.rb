# coding: utf-8

require_relative 'edit/insert_text'
require_relative 'edit/enter'

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
    attr_reader :edit_buffer

    #The current edit position
    attr_reader :edit_posn

    #How long is the current string?
    def length
      edit_buffer.length
    end

    #The line editor processing loop.
    def edit_loop
      loop do
        resync

        break unless @working

        set_posn(edit_posn - left_margin + prompt.length)
        key_cmd = @term.get_mapped_keystroke
        send(key_cmd[0], key_cmd)
      end
    end
  end

end
