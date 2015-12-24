# coding: utf-8

require_relative "mini_readline/version"
require_relative "mini_readline/read_line"

#The \MiniReadline module. A replacement for the rb_readline gem predicated
#on the notion/hope that the code shouldn't smell like an abandoned fish
#processing plant. To this end, it drops the pretext of being compatible
#with the GNU readline library and instead embraces OOD principles. I hope.
#* mini_readline.rb - The root file that gathers up all the system's parts.
module MiniReadline

  #The instances of Readline with and without history.
  @readers = {true => Readline.new([]), false => Readline.new(nil)}

  #The (limited) compatibility module function.
  def self.readline(prompt, history)
    @readers[history].readline(prompt)
  end
end
