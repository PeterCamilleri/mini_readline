# coding: utf-8

require_relative 'read_line/prompt'
require_relative 'read_line/edit'
require_relative 'read_line/history'
require_relative 'read_line/no_history'

# The ReadLine class that does the actual work.
module MiniReadline

  #The Readline class that does the actual work of getting lines from the
  #user. Note that each instance of this class maintains its own copy of
  #the optional command history.
  class Readline

    # The options specifically associated with this instance.
    attr_reader :instance_options

    # Setup the instance of the mini line editor.
    def initialize(instance_options={})
      @instance_options = instance_options
      log = (@instance_options[:log] || BASE_OPTIONS[:log] || []).clone
      @history    = History.new(log)
      @no_history = NoHistory.new
    end

    # Get the history buffer of this read line instance.
    def history
      @history.history
    end

    # Read a line from the console with edit and history.
    def readline(options = {})
      suppress_warnings
      initialize_parms(options)
      MiniTerm.raw { @edit.edit_process }
    ensure
      restore_warnings
      puts
    end

    # Initialize the read line process. This basically process the arguments
    # of the readline method.
    def initialize_parms(options)
      set_options(options)

      history = @options[:history] ? @history : @no_history
      @edit = Edit.new(history, @options)

      @history.initialize_parms(@options)
    end

    # Set up the options
    def set_options(options)
      @options = MiniReadline::BASE_OPTIONS
                   .merge(instance_options)
                   .merge(options)

      @options[:window_width] = MiniTerm.width - 1
      set_prompt(@options[:prompt])
      verify_mask(@options[:secret_mask])
    end

    # Set up the prompt.
    def set_prompt(prompt)
      @options[:base_prompt]   = Prompt.new(prompt)
      @options[:scroll_prompt] = Prompt.new(@options[:alt_prompt] || prompt)

      verify_prompt(@options[:base_prompt])
      verify_prompt(@options[:scroll_prompt])
    end

    # Verify that the prompt will fit!
    def verify_prompt(prompt)
      unless (@options[:window_width] - prompt.length) >
             (@options[:scroll_step] * 2)
        fail MiniReadlinePLE, "Too long: #{prompt.inspect}"
      end
    end

    # Verify the secret mask
    def verify_mask(secret)
      if secret && secret.length != 1
        fail MiniReadlineSME, "Secret mask must be nil or a single character string."
      end
    end

    # No warnings please!
    def suppress_warnings
      @old_stderr = $stderr
      $stderr = File.open(File::NULL, 'w')
    end

    # Restore warnings to their typical ugliness.
    def restore_warnings
      $stderr.close
      $stderr = @old_stderr
    end

  end
end
