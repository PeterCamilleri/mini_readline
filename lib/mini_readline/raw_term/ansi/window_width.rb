# coding: utf-8

#* ansi/window_width.rb - Determine the available screen width.
module MiniReadline

  #* ansi/window_width.rb - Determine the available screen width.
  class RawTerm

    #Determine the available screen width.
    def window_width
      term_info[1]
    end

    # Determine the console size [rows, columns]
    #<br>Endemic Code Smells
    #* :reek:UtilityFunction
    def term_info
      IO.console.winsize
    end

  end
end
