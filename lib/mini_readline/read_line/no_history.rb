# coding: utf-8

# Support for the edit without history.
module MiniReadline

  # Support for the edit without history.
  class NoHistory

    # Get the history object ready for the next read line operation. NOP
    def initialize_parms(_options)
    end

    # Go to the end of the history array. NOP
    def goto_end_of_history
    end

    # Get the previous history string. NOP
    def get_previous_history
      false
    end

    # Get the next history string. NOP
    def get_next_history
      false
    end

    # Append a string to the history buffer if enabled. NOP
    def append_history(_str)
    end

    # Get the history buffer associated with this instance. Empty
    def history
      []
    end
  end
end
