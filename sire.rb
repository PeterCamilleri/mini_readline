# coding: utf-8
# A Simple Interactive Ruby Environment

require 'pp'

#Some SIRE control variables.
$sire_done    = false
$sire_binding = binding
$sire_old     = (ARGV[0] == 'old') || defined?(Readline)

if $sire_old
  require 'readline'
  class MiniReadlineEOI < StandardError; end #Compatibility stub.
  puts "\nLoaded the standard readline gem. Version #{Readline::VERSION}"
elsif ARGV[0] == 'local'
  require './lib/mini_readline'
  puts "\nOption(local). Loaded mini_readline from the local code folder. Version #{MiniReadline::VERSION}"
elsif defined?(MiniReadline)
  puts "\nThe mini_readline gem is already loaded. Version #{MiniReadline::VERSION}"
else
  begin
    require 'mini_readline'
    puts "\nLoaded mini_readline from the system gem. Version #{MiniReadline::VERSION}"
  rescue LoadError
    begin
      require './lib/mini_readline'
      puts "\nLoaded mini_readline from the local code folder. Version #{MiniReadline::VERSION}"
    rescue LoadError
      require 'readline'
      puts "\nLoaded the standard readline gem. Version #{Readline::VERSION}"
    end
  end
end

Readline = MiniReadline unless defined?(Readline)

class Object
  #Generate the class lineage of the object.
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

  #Quit the interactive session.
  def quit
    $sire_done = true
    puts
    "Quit command."
  end

  #Get a mapped keystroke.
  def get_mapped
    if $sire_old
      puts 'Not supported by old readline.'
    else
      print 'Press a key:'
      MiniReadline::BASE_OPTIONS[:term].get_mapped_keystroke
    end
  end

  #Test spawning a process. This breaks the regular readline gem.
  def run(command)
    IO.popen(command, "r+") do |io|
      io.close_write
      return io.read
    end
  end

end

#The SIRE class contains the simplistic R.E.P.L.
class SIRE

  #Run the interactive session.
  def run_sire
    unless $sire_old
      MiniReadline::BASE_OPTIONS[:auto_complete] = true
      MiniReadline::BASE_OPTIONS[:eoi_detect] = true
    end

    puts
    puts "Welcome to a Simple Interactive Ruby Environment\n"
    puts "Use the command 'quit' to exit.\n\n"

    until $sire_done
      exec_line(get_line)
    end

    puts "\n\n"

  rescue MiniReadlineEOI, Interrupt => e
    puts "\n"
  end

  private

  #Get a line of input from the user.
  def get_line
    initial_input = Readline.readline("SIRE>", true)
    get_extra_input(initial_input)
  end

  #Get any continuations of the inputs
  def get_extra_input(str)
    if /\\\s*$/ =~ str
      get_extra_input($PREMATCH + "\n" + Readline.readline("SIRE\\", true))
    else
      str
    end
  end

  #Execute a single line.
  def exec_line(line)
    result = $sire_binding.eval(line)
    pp result unless line.length == 0

  rescue Interrupt => e
    puts "\nExecution Interrupted!"
    puts "\n#{e.class} detected: #{e}\n"
    puts e.backtrace
    puts "\n"

  rescue Exception => e
    puts "\n#{e.class} detected: #{e}\n"
    puts e.backtrace
    puts
  end

end

if __FILE__ == $0
  SIRE.new.run_sire
end
