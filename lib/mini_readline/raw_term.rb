# coding: utf-8

#* raw_term.rb - Platform determination for raw terminal access.
module MiniReadline

  #Select the type of platform in use.
  if (RUBY_PLATFORM =~ /\bcygwin\b/i) || (RUBY_PLATFORM !~ /mswin|mingw/)
    require_relative 'raw_term/ansi'
  else
    require_relative 'raw_term/windows'
  end

  #Get an instance of a raw terminal controller object.
  BASE_OPTIONS[:term] = RawTerm.new
end
