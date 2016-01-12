# coding: utf-8

#* other/map.rb - Character mapping for other systems.
module MiniReadline

  #* other/map.rb - Character mapping for other systems.
  class RawTerm

    #Map the non-printing characters.

    #Left Arrows
    MAP["\e[D"]  = [:go_left]
    MAP["\e[D"]  = [:go_left]

    MAP["\e[1;5D"] = [:word_left]
    MAP["\x02"]    = [:word_left]
    MAP["\eb"]     = [:word_left]

    #Right Arrows
    MAP["\e[C"]  = [:go_right]
    MAP["\eOC"]  = [:go_right]

    MAP["\e[1;5C"] = [:word_right]
    MAP["\x06"]    = [:word_right]
    MAP["\ef"]     = [:word_right]

    #Up Arrows
    MAP["\e[A"]  = [:previous_history]
    MAP["\eOA"]  = [:previous_history]
    MAP["\x12"]  = [:previous_history]

    #Down Arrows
    MAP["\e[B"]  = [:next_history]
    MAP["\eOB"]  = [:next_history]

    #The Home keys
    MAP["\e[H"]  = [:go_home]
    MAP["\eOH"]  = [:go_home]
    MAP["\x01"]  = [:go_home]

    #The End keys
    MAP["\e[F"]  = [:go_end]
    MAP["\eOF"]  = [:go_end]
    MAP["\x05"]  = [:go_end]

    #The Backspace key
    MAP["\x7F"]  = [:delete_left]
    MAP["\x08"]  = [:delete_left]

    #The Delete keys
    MAP["\x1F"]  = [:delete_right]
    MAP["\e[3~"] = [:delete_right]

    #Auto-completion.
    MAP["\t"]    = [:auto_complete]

    #The Enter key
    MAP["\x0D"]  = [:enter]

    #The Cancel key
    MAP["\f"]    = [:cancel]
  end
end