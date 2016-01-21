# coding: utf-8

require_relative 'raw_term/mapper'

#* raw_term.rb - Platform determination for raw terminal access.
module MiniReadline

  #The class used to manipulate console i/o on a low level.
  #<br>Endemic Code Smells
  # :reek:TooManyInstanceVariables
  class RawTerm

    #Create a mapper.
    MAP = Mapper.new

    #Map the printable characters.
    (32..126).each do |code|
      char = code.chr
      MAP[char] = [:insert_text, char]
    end

    #Get a mapped sequence.
    def get_mapped_keystroke
      MAP.get_mapped_keystroke {get_raw_char}
    end
  end

  #Select the type of platform in use.
  if (RUBY_PLATFORM =~ /\bcygwin\b/i) || (RUBY_PLATFORM !~ /mswin|mingw/)
    require_relative 'raw_term/other'
  else
    require_relative 'raw_term/windows'
  end

  #Get an instance of a raw terminal controller object.
  BASE_OPTIONS[:term] = RawTerm.new
end
