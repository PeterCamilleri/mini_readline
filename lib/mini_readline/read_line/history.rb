# coding: utf-8

# Edit history support
module MiniReadline

  # Support for the edit history.
  class History

    # Setup the history array of the mini line editor.
    def initialize(buffer)
      @_buffer = buffer
      goto_end_of_history
    end

    # Get the history object ready for the next read line operation.
    def initialize_parms(options)
      @options = options
      goto_end_of_history
    end

    # Go to the end of the history array.
    def goto_end_of_history
      @history_cursor = history.length
    end

    # Get the previous history string.
    def get_previous_history
      if @history_cursor > 0
        @history_cursor -= 1
        self.history[@history_cursor]
      else
        false
      end
    end

    # Get the next history string
    def get_next_history
      if @history_cursor < history.length
        @history_cursor += 1
        history[@history_cursor] || ""
      else
        false
      end
    end

    # Append a string to the history buffer if enabled.
    def append_history(str)
      return if @options[:no_blanks] && str.strip.empty?

      if history[str]
        if @options[:no_dups]
          return if @options[:no_move]

          history.delete(str)
        end
      end

      history << str
    end

    # Get the history buffer associated with this instance.
    def history
      @_buffer
    end
  end
end
