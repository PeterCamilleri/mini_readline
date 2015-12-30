# coding: utf-8

#* read_line/window/resync.rb - Keeping the screen in sync.
module MiniReadline

  #* read_line/window/resync.rb - Keeping the screen in sync.
  class Readline

    private

    #Keep things in sync!
    def synch
      window_buffer.clear unless check_margins

    end

    #Verify/update the window margins. Returns true if they're fine.
    def check_margins
      old_margins = [left_margin, right_margin]

      if edit_posn < left_margin
        left_margin  = [edit_posn - scroll_step, 0].max
      elsif edit_posn > right_margin
        right_margin = [edit_posn + scroll_step, length].min
      end

       old_margins == [left_margin, right_margin]
    end

  end

end
