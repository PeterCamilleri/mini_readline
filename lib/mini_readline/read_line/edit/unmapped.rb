# coding: utf-8

# Process :unmapped
module MiniReadline

  # Process :unmapped
  class Edit

    #An unmapped key was pressed. Beep!
    def unmapped(_keyboard_args)
      MiniTerm.beep
    end
  end
end
