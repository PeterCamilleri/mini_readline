# coding: utf-8

# Create the keyboard maps used by mini_readline.

# The Windows mapping.
MiniTerm.add_map(:windows) do |map|
  # Make local copies of the prefixes for brevity.
  x00 = MiniTerm::PREFIX_00
  xe0 = MiniTerm::PREFIX_E0

  map[" ".."~"] = :insert_text

  #Left Arrows
  map[x00+"K"] = :go_left
  map[xe0+"K"] = :go_left

  map[x00+"s"] = :word_left
  map[xe0+"s"] = :word_left

  #Right Arrows
  map[x00+"M"] = :go_right
  map[xe0+"M"] = :go_right

  map[x00+"t"] = :word_right
  map[xe0+"t"] = :word_right

  #Up Arrows
  map[x00+"H"] = :previous_history
  map[xe0+"H"] = :previous_history

  #Down Arrows
  map[x00+"P"] = :next_history
  map[xe0+"P"] = :next_history

  #The Home keys
  map[x00+"G"] = :go_home
  map[xe0+"G"] = :go_home

  #The End keys
  map[x00+"O"] = :go_end
  map[xe0+"O"] = :go_end

  #The Backspace key
  map["\x08"]  = :delete_left

  #The Delete keys
  map["\x7F"]  = :delete_right
  map[x00+"S"] = :delete_right
  map[xe0+"S"] = :delete_right

  #Auto-completion.
  map["\t"]    = :auto_complete

  #The Enter key
  map["\x0D"]  = :enter

  #The Escape key
  map["\e"]    = :cancel

  #End of Input
  map["\x1A"]  = :end_of_input
end

# The ANSI mapping.
MiniTerm.add_map(:ansi) do |map|

  map[" ".."~"] = :insert_text

  #Left Arrows
  map["\e[D"]  = :go_left
  map["\eOD"]  = :go_left
  map["\x02"]  = :go_left

  map["\e[1;5D"] = :word_left
  map["\eb"]     = :word_left

  #Right Arrows
  map["\e[C"]  = :go_right
  map["\eOC"]  = :go_right
  map["\x06"]  = :go_right

  map["\e[1;5C"] = :word_right
  map["\ef"]     = :word_right

  #Up Arrows
  map["\e[A"]  = :previous_history
  map["\eOA"]  = :previous_history
  map["\x12"]  = :previous_history

  #Down Arrows
  map["\e[B"]  = :next_history
  map["\eOB"]  = :next_history

  #The Home keys
  map["\e[H"]  = :go_home
  map["\eOH"]  = :go_home
  map["\x01"]  = :go_home

  #The End keys
  map["\e[F"]  = :go_end
  map["\eOF"]  = :go_end
  map["\x05"]  = :go_end

  #The Backspace key
  map["\x7F"]  = :delete_left
  map["\x08"]  = :delete_left
  map["\x15"]  = :delete_all_left

  #The Delete keys
  map["\x1F"]  = :delete_right
  map["\e[3~"] = :delete_right
  map["\x0B"]  = :delete_all_right

  #Auto-completion.
  map["\t"]    = :auto_complete

  #The Enter key
  map["\x0D"]  = :enter

  #The Cancel key
  map["\f"]    = :cancel

  #End of Input
  map["\ez"] = :end_of_input
end

