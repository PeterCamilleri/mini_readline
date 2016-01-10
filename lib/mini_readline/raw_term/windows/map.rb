# coding: utf-8

#* windows/map.rb - Character mapping for windows systems.
module MiniReadline

  #* windows/map.rb - Character mapping for windows systems.
  class RawTerm

    pfx = 0xE0.chr

    #Map the non-printing characters.

    #Left Arrows
    MAP["\x00K"] = [:go_left]
    MAP[pfx+"K"] = [:go_left]

    #Right Arrows
    MAP["\x00M"] = [:go_right]
    MAP[pfx+"M"] = [:go_right]

    #Up Arrows
    MAP["\x00H"] = [:previous_history]
    MAP[pfx+"H"] = [:previous_history]

    #Down Arrows
    MAP["\x00P"] = [:next_history]
    MAP[pfx+"P"] = [:next_history]

    #The Home keys
    MAP["\x00G"] = [:go_home]
    MAP[pfx+"G"] = [:go_home]

    #The End keys
    MAP["\x00O"] = [:go_end]
    MAP[pfx+"O"] = [:go_end]

    #The Backspace key
    MAP["\x08"]  = [:delete_left]

    #The Delete keys
    MAP["\x7F"]  = [:delete_right]
    MAP["\x00S"] = [:delete_right]
    MAP[pfx+"S"] = [:delete_right]

    #The Enter key
    MAP["\x0D"]  = [:enter]

    #The Escape key
    MAP["\x1B"]  = [:cancel]
  end
end