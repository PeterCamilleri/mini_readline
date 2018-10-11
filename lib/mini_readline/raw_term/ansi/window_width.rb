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

    # Determine the console size [rows, columns]
    def term_info
      IO.console.winsize
    end

  end
end
