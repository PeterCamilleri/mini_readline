# coding: utf-8

#* read_line/window/edit/end_of_input.rb - Process :end_of_input
module MiniReadline

  #* read_line/window/edit/end_of_input.rb - Process :end_of_input
  class Edit

    #The insert_text command. We are DONE!
    def end_of_input(_keyboard_args)
      if @options[:eoi_detect]
        raise MiniReadlineEOI, "EOI Detected."
      else
        @term.beep
      end
    end
  end
end
