# coding: utf-8

require_relative 'edit/edit_window'

require_relative 'edit/insert_text'
require_relative 'edit/enter'

require_relative 'edit/go_left'
require_relative 'edit/word_left'

require_relative 'edit/go_right'
require_relative 'edit/word_right'

require_relative 'edit/go_home'
require_relative 'edit/go_end'

require_relative 'edit/delete_left'
require_relative 'edit/delete_all_left'
require_relative 'edit/delete_right'
require_relative 'edit/delete_all_right'
require_relative 'edit/cancel'

require_relative 'edit/previous_history'
require_relative 'edit/next_history'

require_relative 'edit/auto_complete'
require_relative 'edit/end_of_input'

require_relative 'edit/unmapped'

# The line editor.
module MiniReadline

  # The line editor.
  # :reek:TooManyInstanceVariables  -- Yes and it needs them!
  class Edit

    # Set up the edit instance.
    def initialize(history, options)
      @options     = options
      @history     = history
      @edit_buffer = @options[:initial]
      @edit_posn   = @edit_buffer.length
      @working     = true

      @edit_window = EditWindow.new(@options)
    end

    # The main edit buffer
    attr_reader :edit_buffer

    # The current edit position
    attr_reader :edit_posn

    # How long is the current string?
    def length
      edit_buffer.length
    end

    # Interact with the user
    def edit_process
      result = edit_loop
      @history.append_history(result)
      result + (@options[:chomp] ? "" : "\n")
    end

    # The line editor processing loop.
    def edit_loop
      while @working
        @edit_window.sync_window(edit_buffer, edit_posn)
        @edit_window.sync_cursor(edit_posn)
        process_keystroke(MiniTerm.get_mapped_char)
      end

      edit_buffer
    end

    # Process a keystroke.
    def process_keystroke(key_cmd)
      send(key_cmd[0], key_cmd)
    end
  end
end
