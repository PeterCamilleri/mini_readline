# coding: utf-8
# An IRB + mini_readline Test bed

require 'irb'

puts "Starting an IRB console with mini_readline test bed."

if ARGV[0] == 'old'
  ARGV.shift
  puts "Using the standard readline facility."
  no_patch = true
elsif ARGV[0] == 'local'
  require_relative 'lib/mini_readline'
  puts "mini_readline loaded locally: #{MiniReadline::VERSION}"
  no_patch = false
  ARGV.shift
else
  require 'mini_readline'
  puts "mini_readline loaded from gem: #{MiniReadline::VERSION}"
  no_patch = false
end

puts

#Hack irb to use mini_readline.
unless no_patch
  module IRB
    class ReadlineInputMethod < InputMethod

      def initialize
        super

        @line_no = 0
        @line = []
        @eof = false

        @stdin  = IO.open(STDIN.to_i,
                          :external_encoding => IRB.conf[:LC_MESSAGES].encoding,
                          :internal_encoding => "-")

        @stdout = IO.open(STDOUT.to_i, 'w',
                          :external_encoding => IRB.conf[:LC_MESSAGES].encoding,
                          :internal_encoding => "-")
      end

      def gets
        result = MiniReadline.readline(@prompt, true)
        HISTORY.push(result) unless result.empty?
        @line[@line_no += 1] = result
      end

    end
  end
end

IRB.start
