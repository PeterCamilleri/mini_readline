# coding: utf-8

#* read_line/history.rb - Edit history support
module MiniReadline

  #* read_line/history.rb - Support for the edit history.
  class Readline

    #Get the history associated with this instance.
    def history
      @_history || []
    end

    #Go to the end of the history array.
    def goto_end_of_history
      @history_cursor = self.history.length
    end

    #Setup the history array of the mini line editor.
    def init_history(history)
      @_history = history
      goto_end_of_history
    end

    #Get the previous history string.
    def get_previous_history
      if @history_cursor > 0
        @history_cursor -= 1
        self.history[@history_cursor]
      else
        false
      end
    end

    #Get the next history string
    def get_next_history
      if @history_cursor < history.length
        @history_cursor += 1
        history[@history_cursor] || ""
      else
        false
      end
    end

    #Append a string to the history buffer if enabled.
    def append_history(str)
      str_strip = str.strip

      return if (str_strip == '')                  && @options[:no_blanks]
      return if (history.include?(str_strip)) && @options[:no_dups]

      history << str
    end

  end

end
