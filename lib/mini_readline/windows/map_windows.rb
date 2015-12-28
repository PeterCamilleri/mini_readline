# coding: utf-8

#* map_windows.rb - Character mapping for windows systems.
module MiniReadline

  #* windows/map_wondows.rb - Character to action mapping for windows.
  class RawTerm

    MAP = Hash.new([:unmapped])

    #Map the printable characters.
    (32..126).each do |code|
      char = code.chr
      MAP[char] = [:text, char]
    end

    #Map the non-printing characters.
    MAP["\00"]   = false
    MAP["\E0"]   = false

    MAP["\x00K"] = [:left]
    MAP["\xE0K"] = [:left]

    MAP["\x00M"] = [:right]
    MAP["\xE0M"] = [:right]

    MAP["\x00H"] = [:previous]
    MAP["\xE0H"] = [:previous]

    MAP["\x00G"] = [:home]
    MAP["\xE0G"] = [:home]

    MAP["\x00O"] = [:end]
    MAP["\xE0O"] = [:end]

    MAP["\x08"]  = [:delete_left]

    MAP["\x7F"]  = [:delete_right]
    MAP["\x00S"] = [:delete_right]
    MAP["\xE0S"] = [:delete_right]

    MAP["\x0D"]  = [:enter]

    #Get a mapped sequence.
    def get_mapped_keystroke
      first = get_raw_char

      MAP[first] || MAP[first + get_raw_char] || [:unmapped]
    end


  end


end