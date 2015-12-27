# coding: utf-8
# A Simple Interactive Ruby Environment

require 'readline' #YUK
#require_relative 'lib/mini_readline'
require 'pp'

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

    puts "Welcome to a Simple Interactive Ruby Environment\n"
    puts "Use command 'q' to quit.\n\n"
  end

  #Quit the interactive session.
  def q
    @_done = true
    puts
    "Bye bye for now!"
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
    until @_done
      exec_line(Readline.readline('SIRE>', true))
    end

    puts "\n\n"
  end

end

if __FILE__ == $0
  SIRE.new.run_sire
end
