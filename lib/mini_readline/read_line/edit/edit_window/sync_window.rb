# coding: utf-8

#* read_line/window/sync_window.rb - Keeping the screen in sync.
module MiniReadline

  #* read_line/window/sync_window.rb - Keeping the screen in sync.
  class EditWindow

    #Keep the edit window in sync!
    def sync_window(edit_buffer, edit_posn)
      window_buffer.clear unless check_margins(edit_buffer.length, edit_posn)
      image = build_screen_image(edit_buffer)
      update_screen(image)
      @window_buffer = image
    end

    #Verify/update the window margins. Returns true if they're fine.
    def check_margins(length, edit_posn)
      old_margins = [left_margin, right_margin]

      if length < base_width
        @left_margin = 0
      elsif edit_posn < left_margin
        @left_margin = [edit_posn - scroll_step, 0].max
      elsif edit_posn > right_margin
        self.right_margin = edit_posn + scroll_step
      end

      old_margins == [left_margin, right_margin]
    end

    #Compute what should be on the screen.
    def build_screen_image(edit_buffer)
      prompt + edit_buffer[left_margin..right_margin].ljust(window_width)
    end

    #Bring the screen into agreement with the image.
    def update_screen(image)
      (0...window_width).each do |index|
        if (image_char = image[index]) != window_buffer[index]
          @term.set_posn(index)
          @term.put_string(image_char)
        end
      end
    end

  end
end
