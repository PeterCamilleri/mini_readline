# coding: utf-8
# A Simple Interactive Ruby Environment

require 'pp'

if ARGV[0] == 'old'
  require 'readline'
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
    "Bye bye for now!"
  end

  #Get a mapped keystroke.
  def g
    print 'Press a key:'
    MiniReadline::BASE_OPTIONS[:term].get_mapped_keystroke
  end

  #Test spawning a process. This breaks the regular readline gem.
  def run(command)
    IO.popen(command, "r+") do |io|
      io.close_write
      return io.read
    end
  end

  #Strict Windows Regex.
  # a File name character, no spaces.
  # b File name character, with spaces.
  # c Drive specification.
  # x Non-quoted file spec.
  # y Quoted file spec.
  WRE = %r{
    (?<a> [^\/\\\:\*\?\<\>\"\s]){0}
    (?<b> [^\/\\\:\*\?\<\>\"]){0}
    (?<c> ([a-zA-z]\:)?\\){0}
    (?<x> \g<c>?(\g<a>*\\?)*){0}
    (?<y> \"\g<c>?(\g<a>(\g<b>*\g<a>)?\\?)*\"){0}

    (\g<x>|\g<y>)$
  }x

  #Test the WRE
  def wre(str)
    WRE.match str
  end

  #Rubified Windows Regex.
  # a File name character, no spaces.
  # b File name character, with spaces.
  # c Drive specification.
  # x Non-quoted file spec.
  # y Quoted file spec.
  RRE = %r{
    (?<a> [^\/\\\:\*\?\<\>\"\s]){0}
    (?<b> [^\/\\\:\*\?\<\>\"]){0}
    (?<c> ([a-zA-z]\:)?\/){0}
    (?<x> \g<c>?(\g<a>*\/?)*){0}
    (?<y> \"\g<c>?(\g<a>(\g<b>*\g<a>)?\/?)*\"){0}

    (\g<x>|\g<y>)$
  }x

  #Test the RRE
  def rre(str)
    RRE.match str
  end

  #Other Platforms Regex.
  # a File name character, no spaces.
  # b File name character, with spaces.
  # c Root specification.
  # x Non-quoted file spec.
  # y Quoted file spec.
  ORE = %r{
    (?<a> [^\/\\\:\*\?\<\>\"\s]){0}
    (?<b> [^\/\\\:\*\?\<\>\"]){0}
    (?<c> \/){0}
    (?<x> \g<c>?(\g<a>*\/?)*){0}
    (?<y> \"\g<c>?(\g<a>(\g<b>*\g<a>)?\/?)*\"){0}

    (\g<x>|\g<y>)$
  }x

  #Test the ORE
  def ore(str)
    ORE.match str
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
    puts
    puts "Welcome to a Simple Interactive Ruby Environment\n"
    puts "Use the command 'q' to quit.\n\n"

    until @_done
      exec_line(Readline.readline('SIRE>', true))
    end

    puts "\n\n"

  rescue Interrupt => e
    puts "\n"
  end

end

if __FILE__ == $0
  SIRE.new.run_sire
end
