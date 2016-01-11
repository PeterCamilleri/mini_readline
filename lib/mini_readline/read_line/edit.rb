# coding: utf-8

require_relative 'edit_window'
require_relative 'history'

require_relative 'edit/insert_text'
require_relative 'edit/enter'

require_relative 'edit/go_left'
require_relative 'edit/word_left'

require_relative 'edit/go_right'
require_relative 'edit/word_right'

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
  class Edit

    #Set up the edit instance.
    def initialize(buffer)
      @history     = History.new(buffer)
      @edit_window = EditWindow.new
    end

    #Set up the initial edit settings.
    def initialize_edit_parms(options)
      @options     = options
      @term        = @options[:term]
      @edit_posn   = 0
      @edit_buffer = ""
      @working     = true

      @edit_window.initialize_parms(@options)
      @history.initialize_parms(@options)
    end

    #The main edit buffer
    attr_reader :edit_buffer

    #The current edit position
    attr_reader :edit_posn

    #How long is the current string?
    def length
      edit_buffer.length
    end

    #Get the history array for this edit instance.
    def history
      @history.history
    end

    #Interact with the user
    def edit_process
      result = edit_loop
      @history.append_history(result)
      result
    end

    #The line editor processing loop.
    def edit_loop
      while @working
        @edit_window.sync_window(edit_buffer, edit_posn)
        @edit_window.sync_cursor(edit_posn)
        process_keystroke(@term.get_mapped_keystroke)
      end

      edit_buffer
    end

    #Process a keystroke.
    def process_keystroke(key_cmd)
      send(key_cmd[0], key_cmd)
    end
  end
end
