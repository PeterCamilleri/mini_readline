# coding: utf-8

require_relative 'read_line/edit'
require_relative 'read_line/history'
require_relative 'read_line/no_history'


#* read_line.rb - The ReadLine class that does the actual work.
module MiniReadline

  #The \Readline class that does the actual work of getting lines from the
  #user. Note that each instance of this class maintains its own copy of
  #the optional command history.
  class Readline

    #The options specifically associated with this instance.
    attr_reader :instance_options

    #Setup the instance of the mini line editor.
    #<br>Parameters:
    #* instance_options - A hash of options owned by this \Readline instance.
    def initialize(instance_options={})
      @instance_options = instance_options
      log = (@instance_options[:log] || BASE_OPTIONS[:log] || []).clone
      @history    = History.new(log)
      @no_history = NoHistory.new
    end

    #Get the history buffer of this read line instance.
    def history
      @history.history
    end

    #Read a line from the console with edit and history.
    #<br>Parameters:
    #* prompt - A string used to prompt the user. '>' is popular.
    #* options - A hash of options; Typically symbol: value
    def readline(options = {})
      initialize_parms(options)
      @edit.edit_process
    ensure
      @term.conclude
    end

    #Initialize the read line process. This basically process the arguments
    #of the readline method.
    def initialize_parms(options)
      set_options(options)

      history = @options[:history] ? @history : @no_history
      @edit = Edit.new(history, @options)

      @history.initialize_parms(@options)
    end

    #Set up the options
    def set_options(options)
      @options = MiniReadline::BASE_OPTIONS.merge(instance_options)
      @options.merge!(options)
      (@term = @options[:term]).initialize_parms
      set_prompt(@options[:prompt])
    end

    #Set up the prompt.
    def set_prompt(prompt)
      @options[:base_prompt]   = prompt
      @options[:scroll_prompt] = @options[:alt_prompt] || prompt

      verify_prompt(@options[:base_prompt])
      verify_prompt(@options[:scroll_prompt])
    end

    #Verify that the prompt will fit!
    def verify_prompt(str)
      unless (@options[:window_width] - str.length) >
             (@options[:scroll_step] * 2)
        fail "Prompt too long: #{str.inspect}"
      end
    end
  end
end
