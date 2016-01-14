# coding: utf-8

require_relative "mini_readline/version"
require_relative "mini_readline/options"
require_relative "mini_readline/raw_term"
require_relative "mini_readline/read_line"

#The \MiniReadline module. A replacement for the rb_readline gem predicated
#on the notion/hope that the code shouldn't smell like an abandoned fish
#processing plant. To this end, it drops the pretext of being compatible
#with the GNU readline library and instead embraces OOD principles. I hope.
#* mini_readline.rb - The root file that gathers up all the system's parts.
module MiniReadline

  #The shared instance of Readline.
  @reader = Readline.new()

  #The (limited) compatibility module function.
  def self.readline(prompt, history = nil)
    @reader.readline(prompt, history: history)
  end
end

unless $no_alias_read_line_module
  Readline = MiniReadline
end
