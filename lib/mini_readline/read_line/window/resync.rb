# coding: utf-8

#* read_line/window/resync.rb - Keeping the screen in sync.
module MiniReadline

  #* read_line/window/resync.rb - Keeping the screen in sync.
  class Readline

    private

    #Keep things in sync!
    def synch

    end


    #Verify the window offset
    def check_window_offset
      if edit_posn < window_offset
        window_offset -= scroll_step

      elsif edit_posn >= (window_offset + window_width)
        window_offset += scroll_step

      end
      
      
    end

  end

end
