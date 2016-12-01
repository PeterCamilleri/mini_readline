# coding: utf-8

#* ansi/window_width.rb - Determine the available screen width.
module MiniReadline

  #* ansi/window_width.rb - Determine the available screen width.
  class RawTerm

    #Determine the available screen width.
    #<br>Endemic Code Smells
    #* :reek:UtilityFunction
    def window_width
      IO.console.winsize[1]
    end

  end
end
