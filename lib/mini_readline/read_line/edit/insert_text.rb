# coding: utf-8

#* read_line/window/edit/insert_text.rb - Process :insert_text
module MiniReadline

  #* read_line/window/edit/insert_text.rb - Process :insert_text
  class Readline

    private

    #The insert_text command
    def insert_text(keyboard_args)
      char = keyboard_args[1]
      posn = edit_posn

      self.edit_buffer = edit_buffer[0...posn] + char + edit_buffer[posn..-1]

      edit_posn = posn + 1
    end

  end

end