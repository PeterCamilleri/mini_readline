# coding: utf-8

require_relative 'edit/insert_text'
require_relative 'edit/enter'

require_relative 'edit/go_left'
require_relative 'edit/go_right'

require_relative 'edit/go_home'
require_relative 'edit/go_end'

require_relative 'edit/delete_left'
require_relative 'edit/delete_right'
require_relative 'edit/cancel'

require_relative 'edit/previous_history'
require_relative 'edit/next_history'

require_relative 'edit/unmapped'

#* read_line/edit.rb - The line editor.
module MiniReadline

  #* read_line/edit.rb - The line editor.
  class Readline

    #Set up the initial edit settings.
    def initialize_edit_parms
      @edit_posn, @edit_buffer, @working = 0, "", true
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
        @edit_window.sync_window(edit_buffer, edit_posn)

        break unless @working

        @edit_window.sync_cursor(edit_posn)
        process_keystroke(@term.get_mapped_keystroke)
      end
    end

    #Process a keystroke.
    def process_keystroke(key_cmd)
      send(key_cmd[0], key_cmd)
    end
  end
end
