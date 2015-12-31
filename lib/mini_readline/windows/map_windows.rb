# coding: utf-8

require 'pp'

#* map_windows.rb - Character mapping for windows systems.
module MiniReadline

  #* windows/map_wondows.rb - Character to action mapping for windows.
  class RawTerm

    #Build the keystroke mapping hash.
    def build_map
      #Create a hash with a default value of [:unmapped]
      @map = Hash.new {|_hash, key| [:unmapped, key]}

      #Map the printable characters.
      (32..126).each do |code|
        char = code.chr
        @map[char] = [:insert_text, char]
      end

      pfx = 0xE0.chr

      #Map the non-terminal entries.
      @map["\x00"] = false
      @map[  pfx ] = false

      #Map the non-printing characters.

      #Left Arrows
      @map["\x00K"] = [:left]
      @map[pfx+"K"] = [:left]

      #Right Arrows
      @map["\x00M"] = [:right]
      @map[pfx+"M"] = [:right]

      #Up Arrows
      @map["\x00H"] = [:previous_history]
      @map[pfx+"H"] = [:previous_history]

      #Down Arrows
      @map["\x00P"]  = [:next_history]
      @map[pfx+"P"]  = [:next_history]

      #The Home keys
      @map["\x00G"] = [:home]
      @map[pfx+"G"] = [:home]

      #The End keys
      @map["\x00O"] = [:end]
      @map[pfx+"O"] = [:end]

      #The Backspace key
      @map["\x08"]  = [:delete_left]

      #The Delete keys
      @map["\x7F"]  = [:delete_right]
      @map["\x00S"] = [:delete_right]
      @map[pfx+"S"] = [:delete_right]

      #The Enter key
      @map["\x0D"]  = [:enter]

      #The Escape key
      @map["\x1B"]   = [:cancel]

      pp @map
      puts

    end

    #Get a mapped sequence.
    def get_mapped_keystroke
      first_char = get_raw_char

      @map[first_char] || @map[first_char + get_raw_char]
    end


  end


end