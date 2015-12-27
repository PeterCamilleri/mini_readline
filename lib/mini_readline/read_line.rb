# coding: utf-8

require_relative 'read_line/history'

#* read_line.rb - The ReadLine class that does the actual work.
module MiniReadline

  #The \Readline class that does the actual work of getting lines from the
  #user. Note that each instance of this class maintains its own copy of
  #the optional command history.
  class Readline

    #Setup the instance of the mini line editor.
    #<br>Parameters:
    #* history - An array of strings used to contain the history. Use the
    #  value nil to maintain no history.
    def initialize(history)
      init_history(history)
    end

  end


end
