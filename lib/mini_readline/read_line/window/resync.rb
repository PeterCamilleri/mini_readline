# coding: utf-8

#* read_line/window/resync.rb - Keeping the screen in sync.
module MiniReadline

  #* read_line/window/resync.rb - Keeping the screen in sync.
  class Readline

    private

    #Keep things in sync!
    def resync
      window_buffer.clear unless check_margins
      image = build_screen_image
      first = find_first_change(image)

      #A temporary hack for testing only.
      @term.put_string "\x0D" + image
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

    #Compute what should be on the screen.
    def build_screen_image
      prompt + edit_buffer[left_margin..right_margin]
    end

    #Where do the two strings begin to differ? Return the index or nil if the
    #new and old screen images are identical.
    def find_first_change(new_image)
      (0...window_width).each do |index|
        return index if new_image[index] != window_buffer[index]
      end

      nil
    end
  end
end
