# coding: utf-8

#* other/map.rb - Character mapping for other systems.
module MiniReadline

  #* other/map.rb - Character mapping for other systems.
  class RawTerm

    #Create a hash with a default value.
    MAP = Hash.new {|_hash, key| [:unmapped, key]}

    #Map the printable characters.
    (32..126).each do |code|
      char = code.chr
      MAP[char] = [:insert_text, char]
    end

    #Map the non-terminal entries.
    MAP["\e"]  = false
    MAP["\e["] = false
    MAP["\eO"] = false

    #Map the non-printing characters.

    #Left Arrows
    MAP["\e[D"]  = [:go_left]
    MAP["\e[D"]  = [:go_left]

    #Right Arrows
    MAP["\e[C"]  = [:go_right]
    MAP["\eOC"]  = [:go_right]

    #Up Arrows
    MAP["\e[A"]  = [:previous_history]
    MAP["\eOA"]  = [:previous_history]

    #Down Arrows
    MAP["\e[B"]  = [:next_history]
    MAP["\eOB"]  = [:next_history]

    #The Home keys
    MAP["\e[H"]  = [:go_home]
    MAP["\eOH"]  = [:go_home]

    #The End keys
    MAP["\e[F"]  = [:go_end]
    MAP["\eOF"]  = [:go_end]

    #The Backspace key
    MAP["\x08"]  = [:delete_left]

    #The Delete keys
    MAP["\x7F"]  = [:delete_right]

    #The Enter key
    MAP["\x0D"]  = [:enter]

    #The Cancel key
    MAP["\x02"]  = [:cancel]

    #Get a mapped sequence.
    def get_mapped_keystroke
      key_seq, key_cmd = "", nil

      begin
        key_seq << get_raw_char
        key_cmd = MAP[key_seq]
      end until key_cmd

    end
  end
end