# coding: utf-8

#* read_line/window.rb - Edit window support.
module MiniReadline

  #* read_line/window.rb - Support for the edit window.
  class Readline

    private

    #Determine the edit window limits.
    def setup_window_parms
      window_width  = @options[:window_width]
      @base_width   = window_width - @options[:base_prompt].length
      @scroll_width = window_width - @options[:scroll_prompt].length

      @window_scrolled, @window_offset, @window_buffer = false, 0, ""
    end

    #Is the window currently in the scrolled state?
    attr_reader :window_scrolled

    #What is the windows offset into the edit string?
    attr_reader :window_offset

    #The shadow copy of what is actually on the screen?
    attr_reader :window_buffer

    #How wide is the window now?
    def window_width
      window_scrolled ? @scroll_width : @base_width
    end

    #What is the current prompt?
    def prompt
      window_scrolled ? @options[:scroll_prompt] : @options[:base_prompt]
    end

  end


end
