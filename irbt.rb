# coding: utf-8
# An IRB + mini_readline Test bed

require 'irb'

puts "Starting an IRB console with mini_readline test bed."

if ARGV[0] == 'old'
  puts "Using the standard readline gem: #{RbReadline::RB_READLINE_VERSION}"
  no_patch = true
  ARGV.shift
elsif ARGV[0] == 'local'
  require_relative 'lib/mini_readline'
  puts "Using mini_readline loaded locally: #{MiniReadline::VERSION}"
  no_patch = false
  ARGV.shift
else
  require 'mini_readline'
  puts "Using mini_readline loaded from gem: #{MiniReadline::VERSION}"
  no_patch = false
end

puts

#Hack irb to use mini_readline.
unless no_patch
  module IRB
    class ReadlineInputMethod < InputMethod

      #Get a string from mini readline.
      def gets
        result = MiniReadline.readline(@prompt, true)
        HISTORY.push(result) unless result.empty?
        @line[@line_no += 1] = result
      end

    end
  end
end

IRB.start
