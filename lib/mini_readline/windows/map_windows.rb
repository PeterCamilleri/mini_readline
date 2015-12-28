# coding: utf-8

#* map_windows.rb - Character mapping for windows systems.
module MiniReadline

  #* windows/map_wondows.rb - Character to action mapping for windows.
  class RawTerm

    MAP = Hash.new([:unmapped])

    #Map the printable characters.
    (32..126).each do |code|
      char = code.chr
      MAP[char] = [:insert_text, char]
    end

    #Map the non-terminal entries.
    MAP["\00"] = false
    MAP["\E0"] = false

    #Map the non-printing characters.

    #Left Arrows
    MAP["\x00K"] = [:left]
    MAP["\xE0K"] = [:left]

    #Right Arrows
    MAP["\x00M"] = [:right]
    MAP["\xE0M"] = [:right]

    #Up Arrows
    MAP["\x00H"] = [:previous_history]
    MAP["\xE0H"] = [:previous_history]

    #Down Arrows
    MAO["\00P"]  = [:next_history]
    MAO["\E0P"]  = [:next_history]

    #The Home keys
    MAP["\x00G"] = [:home]
    MAP["\xE0G"] = [:home]

    #The End keys
    MAP["\x00O"] = [:end]
    MAP["\xE0O"] = [:end]

    #The Backspace key
    MAP["\x08"]  = [:delete_left]

    #The Delete keys
    MAP["\x7F"]  = [:delete_right]
    MAP["\x00S"] = [:delete_right]
    MAP["\xE0S"] = [:delete_right]

    #The Enter key
    MAP["\x0D"]  = [:enter]

    #The Escape key
    MAP["\1B"]   = [:cancel]

    #Get a mapped sequence.
    def get_mapped_keystroke
      first_char = get_raw_char

      MAP[first_char] || MAP[first_char + get_raw_char]
    end


  end


end