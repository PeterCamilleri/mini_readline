# coding: utf-8

require          "English"
require_relative "mini_readline/version"
require_relative "mini_readline/exceptions"
require_relative "mini_readline/options"
require_relative "mini_readline/raw_term"
require_relative "mini_readline/read_line"

#The \MiniReadline module.
#* mini_readline.rb - The root file that gathers up all the system's parts.
module MiniReadline

  private_constant :Prompt
  private_constant :Edit
  private_constant :EditWindow
  private_constant :History
  private_constant :NoHistory

  #Get the shared instance of Readline.
  def self.get_reader
    @reader ||= Readline.new()
  end

  #The (limited) compatibility module function.
  def self.readline(prompt = "", history = nil, options = {})
    get_reader.readline(options.merge({prompt: prompt, history: history}))
  end

end

if defined?($force_alias_read_line_module) && $force_alias_read_line_module
  warn "mini_readline: $force_alias_read_line_module is deprecated."
end

#Optionally: Setup the module alias for Readline
begin
  old_stderr = $stderr
  $stderr = File.open(File::NULL, 'w')

  if !$no_alias_read_line_module && ($force_alias_read_line_module || !defined? Readline)
    Readline = MiniReadline
  end
ensure
  $stderr.close
  $stderr = old_stderr
end
