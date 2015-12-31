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
      update_screen(image)
      window_buffer = image
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
      prompt + edit_buffer[left_margin..right_margin].ljust(window_width)
    end

    #Bring the screen into agreement with the image.
    #<br>Endemic Code Smells
    #* :reek:TooManyStatements - The way things are!
    def update_screen(image)
      base, changes = find_first_difference(image), ""

      (base...window_width).each do |index|
        changes << (image_char = image[index])

        if image_char != window_buffer[index]
          set_posn(base)
          @term.put_string changes
          changes.clear
          base = index + 1
        end
      end
    end

    #Find the first point of difference.
    def find_first_difference(image)
      (0...window_width).each do |index|
        return index if image[index] != window_buffer[index]
      end

      window_width
    end

  end
end
