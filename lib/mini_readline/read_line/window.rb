# coding: utf-8

require_relative 'window/resync'

#* read_line/window.rb - Edit window support.
module MiniReadline

  #* read_line/window.rb - Support for the edit window.
  class Readline

    #Determine the edit window limits.
    def setup_window_parms
      @base_width   = window_width - @options[:base_prompt].length
      @scroll_width = window_width - @options[:scroll_prompt].length

      @left_margin, @window_buffer = 0, ""
    end

    #What is the offset of the window's left margin?
    attr_accessor :left_margin

    #What is the offset of the window's right margin?
    def right_margin
      left_margin + active_width - 1
    end

    #Set the right margin
    #<br>Notes
    #* If the right_margin is being set, then we must be scrolling. That is
    #  why the scroll_width is used instead of active_width here.
    def right_margin=(value)
      @left_margin = value - scroll_width + 1
    end

    #Is the window currently in the scrolled state?
    def window_scrolled?
      left_margin > 0
    end

    #The shadow copy of what is actually on the screen?
    attr_accessor :window_buffer

    #The width of the window with the base prompt
    attr_reader :base_width

    #The width of the window with the alternate prompt
    attr_reader :scroll_width

    #What is the full window width?
    def window_width
      @options[:window_width]
    end

    #How wide is the active region of the window now?
    def active_width
      window_scrolled? ? scroll_width : base_width
    end

    #What is the current prompt?
    def prompt
      window_scrolled? ? @options[:scroll_prompt] : @options[:base_prompt]
    end

    #What is the scroll step?
    def scroll_step
       @options[:scroll_step]
    end
  end
end
