# coding: utf-8

#* read_line/history.rb - Edit history support
module MiniReadline

  #The \Readline class that does the actual work of getting lines from the
  #user. Note that each instance of this class maintains its own copy of
  #the optional command history.
  class Readline

    #Get the history associated with this instance.
    def history
      @_history || []
    end

    #Go to the end of the history array.
    def goto_end_of_history
      @history_cursor = history.length
    end

    #Get the current history entry.
    def get_current_history
      history[@history_cursor] || ""
    end

    private

    #Setup the history array of the mini line editor.
    def init_history(history)
      @_history = history
    end

  end


end
