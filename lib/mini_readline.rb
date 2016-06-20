# coding: utf-8

require          "English"
require_relative "mini_readline/version"
require_relative "mini_readline/exceptions"
require_relative "mini_readline/options"
require_relative "mini_readline/raw_term"
require_relative "mini_readline/read_line"

#The \MiniReadline module. A replacement for the rb_readline gem predicated
#on the notion/hope that the code shouldn't smell like an abandoned fish
#processing plant. To this end, it drops the pretext of being compatible
#with the GNU readline library and instead embraces OOD principles. I hope.
#* mini_readline.rb - The root file that gathers up all the system's parts.
module MiniReadline

  private_constant :Prompt
  private_constant :Edit
  private_constant :EditWindow
  private_constant :History
  private_constant :NoHistory

  #The shared instance of Readline.
  @reader = MiniReadline::Readline.new()

  #The (limited) compatibility module function.
  def self.readline(prompt = "", history = nil)
    @reader.readline(prompt: prompt, history: history)
  end

  #A stub.
  def self.input=(input)
    input
  end

  #A stub.
  def self.output=(output)
    output
  end

  #A stub.
  def self.readline_attempted_completion_function(*_)
    nil
  end

end

#Optionally: Setup the module alias for Readline
begin
  old_stderr = $stderr
  $stderr = File.open(File::NULL, 'w')

  if !$no_alias_read_line_module&&($force_alias_read_line_module||!defined? Readline)
      Readline = MiniReadline
  end
ensure
  $stderr.close
  $stderr = old_stderr
end
