# coding: utf-8

# Process :insert_text
module MiniReadline

  # Process :insert_text
  class Edit

    # The insert_text command
    def insert_text(keyboard_args)
      @edit_buffer = @edit_buffer[0...@edit_posn] +
                     keyboard_args[1] +
                     @edit_buffer[@edit_posn..-1]

      @edit_posn += 1
    end
  end
end
