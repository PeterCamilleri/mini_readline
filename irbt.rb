# coding: utf-8
# An IRB + mini_readline Test bed

require 'irb'
$force_alias_read_line_module = true

puts "Starting an IRB console with mini_readline test bed."

if ARGV[0] == 'old'
  ARGV.shift
elsif ARGV[0] == 'local'
  require_relative 'lib/mini_readline'
  puts "mini_readline loaded locally: #{MiniReadline::VERSION}"

  ARGV.shift
else
  require 'mini_readline'
  puts "mini_readline loaded from gem: #{MiniReadline::VERSION}"
end

IRB.start
