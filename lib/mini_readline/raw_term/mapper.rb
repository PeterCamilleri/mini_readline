# coding: utf-8

#* raw_term/mapper.rb - Support for keystroke mapping.
module MiniReadline

  #* raw_term/mapper.rb - Support for keystroke mapping.
  class Mapper

    #Set up the keystroke mapper.
    def initialize
      @map = Hash.new {|_hash, key| [:unmapped, key]}
    end

    #Add a map entry
    def []=(index, value)
      process_non_terminals(index)
      @map[index] = value
    end

    def process_non_terminals(index)
      seq = ""

      index.chop.chars.each do |char|
        seq << char
        fail "Ambiguous entry" if @map.has_key?(seq) && @map[seq]
        @map[seq] = false
      end
    end

    #Get a mapped input sequence.
    def get_mapped_keystroke
      key_seq, key_cmd = "", nil

      begin
        key_seq << yield
        key_cmd = @map[key_seq]
      end until key_cmd

      key_cmd
    end
  end
end
