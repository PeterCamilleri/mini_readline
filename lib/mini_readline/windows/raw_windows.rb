# coding: utf-8

require_relative 'win_32_api'

#* raw_windows.rb - Support for raw terminal access in windows systems.
module MiniReadline

  #The detected platform is windows.
  PLATFORM = :windows

  #The class used to manipulate console i/o on a low level.
  class RawTerm

    #The sleep interval waiting for a key to be pressed.
    WAIT_SLEEP = 0.02



  end


end
