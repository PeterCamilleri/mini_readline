# coding: utf-8

#* windows/window_width.rb - Determine the available screen width.
module MiniReadline

  #* windows/window_width.rb - Determine the available screen width.
  class RawTerm

    #Determine the available screen width.
    def window_width
      raw_buffer = 0.chr * 24
      get_screen_info(raw_buffer)
      (raw_buffer[0,2].unpack('S'))[0]
    end

  end
end
