# coding: utf-8

# Keep the cursor in sync.
module MiniReadline

  # Keep the cursor in sync.
  class EditWindow

    # Keep the cursor in sync!
    def sync_cursor(edit_posn)
      MiniTerm.set_posn(column: edit_posn - left_margin + prompt.length)
    end

  end
end
