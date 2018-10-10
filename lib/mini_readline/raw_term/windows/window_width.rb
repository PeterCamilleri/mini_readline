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

    def term_info
      raw_buffer = 0.chr * 24
      get_screen_info(raw_buffer)

      left, top, right, bottom = raw_buffer[10,8].unpack('SSSS')

      [right - left + 1, bottom - top + 1]
    end

  end
end
