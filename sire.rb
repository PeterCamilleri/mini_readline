# coding: utf-8
# A Simple Interactive Ruby Environment

require 'pp'

if ARGV[0] == 'old'
  require 'readline'
  $old = true
  puts "\nOption(old). Loaded the standard readline gem. Version #{Readline::VERSION}"
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
end

class SIRE
  #Set up the interactive session.
  def initialize
    @_done = false
  end

  #Quit the interactive session.
  def q
    @_done = true
    puts
    "Quit command."
  end

  #Get a mapped keystroke.
  def g
    if $old
      print 'Not supported by old readline.'
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

  #Execute a single line.
  def exec_line(line)
    result = eval line
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

  #Run the interactive session.
  def run_sire
    unless $old
      MiniReadline::BASE_OPTIONS[:auto_complete] = true
      MiniReadline::BASE_OPTIONS[:eoi_detect] = true
    end

    puts
    puts "Welcome to a Simple Interactive Ruby Environment\n"
    puts "Use the command 'q' to quit.\n\n"

    until @_done
      exec_line(Readline.readline("SIRE>", true))
    end

    puts "\n\n"

  rescue StandardError, Interrupt => e
    puts "\n"
  end

end

if __FILE__ == $0
  SIRE.new.run_sire
end
