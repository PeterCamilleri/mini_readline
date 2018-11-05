# coding: utf-8

# Support for the specialized prompt string class.
module MiniReadline

  # A class used to hold prompt strings that may contain ANSI terminal
  # control embellishments.
  class Prompt

    # Get the text.
    attr_reader :text

    # Get the length without ANSI sequences.
    attr_reader :length

    # Create a special prompt text.
    def initialize(text)
      @text = text
      @length = text.gsub(/\x1B\[(\d|;)*[@-~]/, "").length
    end

    # Inspect the prompt
    def inspect
      "<Prompt: #{@text.inspect}>"
    end

  end

end
