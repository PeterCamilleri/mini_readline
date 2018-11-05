# coding: utf-8

#* read_line/window/edit/unmapped.rb - Process :unmapped
module MiniReadline

  #* read_line/window/edit/unmapped.rb - Process :unmapped
  class Edit

    #An unmapped key was pressed. Beep!
    def unmapped(_keyboard_args)
      MiniTerm.beep
    end
  end
end
