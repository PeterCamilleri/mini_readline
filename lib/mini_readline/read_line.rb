# coding: utf-8

require_relative 'read_line/edit'

#* read_line.rb - The ReadLine class that does the actual work.
module MiniReadline

  #The \Readline class that does the actual work of getting lines from the
  #user. Note that each instance of this class maintains its own copy of
  #the optional command history.
  class Readline

    #Setup the instance of the mini line editor.
    #<br>Parameters:
    #* buffer - An array of strings used to contain the history. Use an empty
    #  array to have a history buffer with no initial entries. Use the
    #  value nil (or false) to maintain no history at all.
    def initialize(buffer=[])
      @edit = Edit.new(buffer)
    end

    #Get the history buffer of this read line instance.
    def history
      @edit.history
    end

    #Read a line from the console with edit and history.
    #<br>Parameters:
    #* prompt - A string used to prompt the user. '>' is popular.
    #* options - A hash of options; Typically :symbol => value
    def readline(prompt, options = {})
      initialize_parms(prompt, options)
      result = @edit.edit_process
      @term.put_new_line
      result
    end

    #Initialize the read line process. This basically process the arguments
    #of the readline method.
    def initialize_parms(prompt, options)
      @options = MiniReadline::BASE_OPTIONS.merge(options)
      (@term = @options[:term]).initialize_parms

      set_prompt(prompt)
      @edit.initialize_edit_parms(@options)
    end

    #Set up the prompt options.
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
