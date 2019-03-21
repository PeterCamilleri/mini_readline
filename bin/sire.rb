# coding: utf-8
# A Simple Interactive Ruby Environment

require 'pp'

# Capture a binding for code evaluation.
sire_binding = binding

# Process command line arguments.
valid_options = {'local' => :reader,
                 'gem'   => :reader,
                 'old'   => :reader,
                 'help'  => :help,
                 '?'     => :help}

options = {reader: 'gem'}

# Display help for SIRE and exit.
def display_help(error=nil)
  puts "SIRE: a Simple Interactive Ruby Environment\n"

  if error
    puts "Invalid option: #{error}"
  end

  puts "", "Usage: sire <options>"
  puts "  local       Use the local mini_readline code."
  puts "  gem         Use the mini_readline installed gem."
  puts "  old         Use the standard readline gem."
  puts "  help  -?    Display this help and exit."

  exit
end

ARGV.each do |arg|
  key = valid_options[arg]
  display_help(arg) unless key
  options[key] = arg
end

display_help if options[:help]

case options[:reader]
when 'local'
  require_relative '../lib/mini_readline'
  puts "", "Option(local). Loaded mini_readline from the local code folder. Version #{MiniReadline::VERSION}"
when 'gem'
  require 'mini_readline'
  puts "", "Loaded mini_readline from the system gem. Version #{MiniReadline::VERSION}"
when 'old'
  require 'readline'
  class MiniReadlineEOI < StandardError; end #Compatibility stub.
  puts "", "Loaded the standard readline gem. Version #{Readline::VERSION}"
end

MiniReadline = Readline unless defined?(MiniReadline)

class Object
  # Generate the class lineage of the object.
  def classes
    begin
      result = ""
      klass  = self.instance_of?(Class) ? self : self.class

      begin
        result << klass.to_s
        klass = klass.superclass
        result << " < " if klass
      end while klass

      result
    end
  end

  private

  # Quit the interactive session.
  def quit
    puts "Quit command.", ""
    exit
  end

  # Get a mapped keystroke.
  def get_mapped
    if old?
      puts 'Not supported by old readline.'
    else
      print 'Press a key: '
      MiniTerm.get_mapped_char
    end
  end

  # Test spawning a process. This breaks the regular readline gem.
  def run(command)
    IO.popen(command, "r+") do |io|
      io.close_write
      return io.read
    end
  end

  def old?
    defined?(Readline)
  end

end

#The SIRE module contains a simplistic R.E.P.L. to test out mini_readline.
module SIRE

  # Run the interactive session.
  def self.run_sire(evaluator)
    @evaluator = evaluator

    unless old?
      MiniReadline::BASE_OPTIONS[:auto_complete] = true
      MiniReadline::BASE_OPTIONS[:eoi_detect] = true
    end

    puts
    puts "Welcome to a Simple Interactive Ruby Environment\n"
    puts "Use the command 'quit' to exit.\n\n"

    loop do
      exec_line(get_line)
    end

    puts "\n\n"

  rescue MiniReadlineEOI, Interrupt => e
    puts "\n"
  end

  private

  # Get a line of input from the user.
  def self.get_line
    initial_input = MiniReadline.readline("SIRE>", true)
    get_extra_input(initial_input)
  end

  # Get any continuations of the inputs
  def self.get_extra_input(str)
    if /\\\s*$/ =~ str
      get_extra_input($PREMATCH + "\n" + MiniReadline.readline("SIRE\\", true))
    else
      str
    end
  end

  # Execute a single line.
  def self.exec_line(line)
    result = @evaluator.eval(line)
    pp result unless line.length == 0

  rescue Interrupt => e
    puts "\nExecution Interrupted!"
    puts "\n#{e.class} detected: #{e}\n"
    puts e.backtrace
    puts "\n"

  rescue StandardError, ScriptError => e
    puts "\n#{e.class} detected: #{e}\n"
    puts e.backtrace
    puts
  end

end

SIRE.run_sire(sire_binding)
