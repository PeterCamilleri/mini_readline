# coding: utf-8

#* options.rb - Options selection, control, and access
module MiniReadline

  #The base options shared by all instances.
  BASE_OPTIONS = {:window_width  => 79,       #The width of the edit area.
                  :scroll_step   => 12,       #The amount scrolled.

                  :prompt        => ">",      #The default prompt.
                  :alt_prompt    => "<< ",    #The prompt when scrolled.
                                              #Set to nil to use main prompt.

                  :auto_complete => false,    #Is auto complete enabled?
                  :auto_source   => nil,      #Filled in by auto_complete.rb

                  :eoi_detect    => false,    #Is end of input detection enabled?

                  :history       => false,    #Is the history buffer enabled?
                  :log           => [],       #Default is no previous history
                  :no_blanks     => true,     #No empty lines in history.
                  :no_dups       => true,     #No duplicate lines in history.

                  :term          => nil,      #Filled in by raw_term.rb

                  :debug         => false     #Used during development only.
                 }
end
