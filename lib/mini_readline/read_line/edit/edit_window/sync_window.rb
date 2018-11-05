# coding: utf-8

# Keeping the screen in sync.
module MiniReadline

  # Keeping the screen in sync.
  class EditWindow

    # Keep the edit window in sync!
    def sync_window(edit_buffer, edit_posn)
      unless check_margins(edit_buffer.length, edit_posn)
        window_buffer.clear
        @show_prompt = true
      end

      image = build_screen_image(edit_buffer)
      update_screen(image)
      @window_buffer = image
    end

    # Verify/update the window margins. Returns true if they're fine.
    def check_margins(length, edit_posn)
      old_margins = [left_margin, right_margin]

      if length < base_width
        set_left_margin(0)
      elsif edit_posn < left_margin
        set_left_margin([edit_posn - scroll_step, 0].max)
      elsif edit_posn > right_margin
        set_right_margin(edit_posn + scroll_step)
      end

      old_margins == [left_margin, right_margin]
    end

    # Compute what should be on the screen.
    def build_screen_image(edit_buffer)
      working_region = edit_buffer[left_margin..right_margin]

      if (mask = @options[:secret_mask])
        mask[0] * working_region.length
      else
        working_region
      end.ljust(active_width)
    end

    # Bring the screen into agreement with the image.
    def update_screen(image)
      if @show_prompt
        MiniTerm.print("\r#{prompt.text}\r")
        @show_prompt = false
      end

      (0...active_width).each do |index|
        if (image_char = image[index]) != window_buffer[index]
          MiniTerm.set_posn(column: prompt.length + index)
          MiniTerm.print(image_char)
        end
      end
    end
  end
end
