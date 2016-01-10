# coding: utf-8

#Select the type of platform in use.
if (RUBY_PLATFORM =~ /\bcygwin\b/i) || (RUBY_PLATFORM !~ /mswin|mingw/)
  require_relative 'raw_term/other'
else
  require_relative 'raw_term/windows'
end

#* raw_term.rb - Platform determination for raw terminal access.
module MiniReadline

  #The class used to manipulate console i/o on a low level.
  class RawTerm

    #Start on a new line.
    def put_new_line
      print("\n")
    end

  end

  #Get an instance of a raw terminal controller object.
  BASE_OPTIONS[:term] = RawTerm.new
end
