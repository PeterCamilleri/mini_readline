# coding: utf-8

require_relative 'mapped_term/mapper'

#* raw_term/mapped_term.rb - Base class for a terminal with key mapping.
module MiniReadline

  #The class used for terminal i/o that is mapped to command sequences.
  class RawTerm

    #Create a mapper.
    MAP = Mapper.new

    #Set up the printable characters.
    MAP.map_ascii(:insert_text)

    #Get a mapped sequence.
    def get_mapped_keystroke
      MAP.get_mapped_keystroke {get_raw_char}
    end
  end

end
