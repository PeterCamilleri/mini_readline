# coding: utf-8

# Process :end_of_input
module MiniReadline

  # Process :end_of_input
  class Edit

    #The insert_text command. We are DONE!
    def end_of_input(_keyboard_args)
      if @options[:eoi_detect]
        raise MiniReadlineEOI, "End of input detected."
      else
        MiniTerm.beep
      end
    end
  end
end
