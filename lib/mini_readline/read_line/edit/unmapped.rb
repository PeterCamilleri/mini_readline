# coding: utf-8

#* read_line/window/edit/unmapped.rb - Process :unmapped
module MiniReadline

  #* read_line/window/edit/unmapped.rb - Process :unmapped
  class Readline

    #An unmapped key was pressed. Beep!
    def unmapped(keyboard_args)
      if @options[:debug]
        puts keyboard_args.inspect
      end

      @term.beep
    end
  end
end
