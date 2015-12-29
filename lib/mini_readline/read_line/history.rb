# coding: utf-8

#* read_line/history.rb - Edit history support
module MiniReadline

  #* read_line/history.rb - Support for the edit history.
  class Readline

    #Get the history associated with this instance.
    def history
      @_history || []
    end

    private

    #Go to the end of the history array.
    def goto_end_of_history
      @history_cursor = history.length
    end

    #Get the current history entry.
    def get_current_history
      history[@history_cursor] || ""
    end

    #Setup the history array of the mini line editor.
    def init_history(history)
      @_history = history
      goto_end_of_history
    end

  end

end
