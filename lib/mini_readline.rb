# coding: utf-8

require "English"

require "mini_term"
MiniTerm.open(quiet: true, pass_ctrl_s: true)

require_relative "mini_readline/maps"
require_relative "mini_readline/version"
require_relative "mini_readline/exceptions"
require_relative "mini_readline/options"
require_relative "mini_readline/read_line"

# The MiniReadline main module.
module MiniReadline

  # The (limited) compatibility module function.
  def self.readline(prompt = "", history = nil, options = {})
    get_reader.readline(options.merge({prompt: prompt, history: history}))
  end

private

  # Get the shared instance of Readline.
  def self.get_reader
    @reader ||= Readline.new()
  end
end
