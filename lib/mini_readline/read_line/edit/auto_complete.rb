# coding: utf-8

require_relative 'auto_complete/auto_manager'
require_relative 'auto_complete/file_folder_source'
require_relative 'auto_complete/quoted_file_folder_source'

#* read_line/window/edit/auto_complete.rb - Process :auto_complete
module MiniReadline

  #Set up the default auto-complete data source.
  BASE_OPTIONS[:auto_source] = QuotedFileFolderSource

  #* read_line/window/edit/auto_complete.rb - Process :auto_complete
  class Edit

    #The auto-complete command.
    def auto_complete(_keyboard_args)
      if @options[:auto_complete] && (new_buffer = auto_manager.next(auto_trim))
        @edit_buffer = new_buffer
        @edit_posn   = length
      else
        @term.beep
      end
    end

    #Get the base part of the edit buffer.
    def auto_trim
      @edit_buffer[0...(@edit_posn)]
    end

    #Get the auto-complete manager
    def auto_manager
      @_auto_manager ||= AutoManager.new{@options[:auto_source].new(@options)}
    end
  end

end
