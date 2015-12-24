# coding: utf-8

#* read_line.rb - The ReadLine class that does the actual work.
module MiniReadline

  #The \Readline class that does the actual work of getting lines from the
  #user. Note that each instance of this class maintains its own copy of
  #the optional command history.
  class Readline

    #Setup the instance of the mini line editor.
    #<br>Parameters:
    #* history - An array of strings used to contain the history. Use the
    #  value nil for no history.
    #<br>Note:
    #* No other access to @_history is allowed.
    def initialize(history)
      @_history = history
    end

    #Get the history associated with this instance.
    def history
      @_history || []
    end

  end


end
