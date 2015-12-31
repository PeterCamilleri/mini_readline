# coding: utf-8

#* map_windows.rb - Character mapping for windows systems.
module MiniReadline

  #* windows/map_wondows.rb - Character to action mapping for windows.
  class RawTerm

    #Create a hash with a default value.
    MAP = Hash.new {|_hash, key| [:unmapped, key]}

    #Map the printable characters.
    (32..126).each do |code|
      char = code.chr
      MAP[char] = [:insert_text, char]
    end

    pfx = 0xE0.chr

    #Map the non-terminal entries.
    MAP["\x00"] = false
    MAP[  pfx ] = false

    #Map the non-printing characters.

    #Left Arrows
    MAP["\x00K"] = [:left]
    MAP[pfx+"K"] = [:left]

    #Right Arrows
    MAP["\x00M"] = [:right]
    MAP[pfx+"M"] = [:right]

    #Up Arrows
    MAP["\x00H"] = [:previous_history]
    MAP[pfx+"H"] = [:previous_history]

    #Down Arrows
    MAP["\x00P"] = [:next_history]
    MAP[pfx+"P"] = [:next_history]

    #The Home keys
    MAP["\x00G"] = [:home]
    MAP[pfx+"G"] = [:home]

    #The End keys
    MAP["\x00O"] = [:end]
    MAP[pfx+"O"] = [:end]

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

    #Get a mapped sequence.
    def get_mapped_keystroke
      first_char = get_raw_char

      MAP[first_char] || MAP[first_char + get_raw_char]
    end


  end


end