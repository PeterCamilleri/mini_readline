# coding: utf-8

require_relative 'read_line/window'
require_relative 'read_line/history'
require_relative 'read_line/edit'

#* read_line.rb - The ReadLine class that does the actual work.
module MiniReadline

  #The \Readline class that does the actual work of getting lines from the
  #user. Note that each instance of this class maintains its own copy of
  #the optional command history.
  class Readline

    #Setup the instance of the mini line editor.
    #<br>Parameters:
    #* history - An array of strings used to contain the history. Use an empty
    #  array to have a history buffer with no initial entries. Use the
    #  value nil (or false) to maintain no history at all.
    def initialize(history=[])
      init_history(history)
    end

    #Read a line from the console with edit and history.
    #<br>Parameters:
    #* prompt - A string used to prompt the user. '>' is popular.
    #* options - A hash of options; Typically :symbol => value
    def readline(prompt, options = {})
      initialize_readline(prompt, options)
      edit_loop
      @term.put_string("\n")
      append_history(edit_buffer)
      edit_buffer
    end

    #Initialize the read line process. This basically process the arguments
    #of the readline method.
    def initialize_readline(prompt, options = {})
      @options, @working = MiniReadline::BASE_OPTIONS.merge(options), true
      (@term = @options[:term]).reset

      set_prompt(prompt)
      initialize_edit_parms
      setup_window_parms
      goto_end_of_history
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
      unless (window_width - str.length) > scroll_step
        fail "Prompt too long: <#{str}>"
      end
    end
  end
end
