# coding: utf-8

require_relative 'win_32_api'
require_relative 'map_windows'

#* raw_windows.rb - Support for raw terminal access in windows systems.
module MiniReadline

  #The detected platform is windows.
  PLATFORM = :windows

  #The class used to manipulate console i/o on a low level.
  class RawTerm

    #The sleep interval waiting for a key to be pressed.
    WAIT_SLEEP = 0.02

    #Set up the Windows Raw Terminal.
    def initialize
      @_getch = Win32API.new("msvcrt", "_getch", [], 'I')
      @_kbhit = Win32API.new("msvcrt", "_kbhit", [], 'I')
      @_beep = Win32API.new("user32","MessageBeep",['L'],'L')
    end

    #Sound a beep
    def beep
      @_beep.call(0)
    end

    private

    #Wait for a key to be pressed.
    def wait_for_key
      while (@_kbhit.call == 0)
        sleep(WAIT_SLEEP)
      end
    end

    #Get a uncooked character keystroke.
    def get_raw_char
      wait_for_key
      @_getch.call.chr
    end

  end


end
