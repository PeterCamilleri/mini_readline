# coding: utf-8

require_relative 'read_line/window'
require_relative 'read_line/history'

#* read_line.rb - The ReadLine class that does the actual work.
module MiniReadline

  #The \Readline class that does the actual work of getting lines from the
  #user. Note that each instance of this class maintains its own copy of
  #the optional command history.
  class Readline

    #Setup the instance of the mini line editor.
    #<br>Parameters:
    #* history - An array of strings used to contain the history. Use the
    #  value nil to maintain no history.
    def initialize(history)
      init_history(history)
      @term = RawTerm.new
    end

    #Read a line from the console with edit and history.
    def readline(prompt, options = {})
      initialize_readline(prompt, options)

      "test"
    end

    private

    #Initialize the read line process.
    def initialize_readline(prompt, options = {})
      @options = MiniReadline::BASE_OPTIONS.merge(options)
      set_prompt(prompt)
      setup_window_parms
    end

    #Set up the prompt options.
    def set_prompt(prompt)
      @options[:base_prompt]   = prompt
      @options[:scroll_prompt] = @options[:alt_prompt] || prompt
    end
  end


end
