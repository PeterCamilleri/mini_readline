# coding: utf-8

require_relative 'edit_window/sync_window'
require_relative 'edit_window/sync_cursor'

# Edit window support.
module MiniReadline

  # Support for the edit window.
  # :reek:TooManyInstanceVariables  -- Yes and it needs them!
  class EditWindow

    # Determine the edit window limits.
    def initialize(options)
      @options      = options
      @base_width   = window_width - @options[:base_prompt].length
      @scroll_width = window_width - @options[:scroll_prompt].length

      @left_margin, @window_buffer, @show_prompt = 0, "", true
    end

    # What is the offset of the window's left margin?
    attr_reader :left_margin

    # What is the offset of the window's right margin?
    def right_margin
      left_margin + active_width - 1
    end

    # Is the window currently in the scrolled state?
    def window_scrolled?
      left_margin > 0
    end

    # The shadow copy of what is actually on the screen?
    attr_reader :window_buffer

    # The width of the window with the base prompt
    attr_reader :base_width

    # The width of the window with the alternate prompt
    attr_reader :scroll_width

    # What is the full window width?
    def window_width
      @options[:window_width]
    end

    # How wide is the active region of the window now?
    def active_width
      window_scrolled? ? scroll_width : base_width
    end

    # What is the current prompt?
    def prompt
      window_scrolled? ? @options[:scroll_prompt] : @options[:base_prompt]
    end

    # What is the scroll step?
    def scroll_step
       @options[:scroll_step]
    end

    private

    # Set the left margin
    def set_left_margin(value)
      @left_margin = value
    end

    # Set the right margin
    # If the right_margin is being set, then we must be scrolling. That is
    # why the scroll_width is used instead of active_width here.
    def set_right_margin(value)
      @left_margin = value - scroll_width + 1
    end
  end
end
