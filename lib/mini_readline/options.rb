# coding: utf-8

#* options.rb - Options selection, control, and access
module MiniReadline

  #The base options shared by all instances.
  BASE_OPTIONS = {:window_width  => 79,       #The width of the edit area.
                  :left_margin   => 10,       #The left edit margin
                  :right_margin  => 10,       #The right edit margin.
                  :alt_prompt    => "<<< "    #The prompt when scrolled.
                 }

end
