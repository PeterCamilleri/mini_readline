# coding: utf-8

#Select the type of platform in use.
if (RUBY_PLATFORM =~ /\bcygwin\b/i) || (RUBY_PLATFORM !~ /mswin|mingw/)
  require_relative 'other/raw_other'
else
  require_relative 'windows/raw_windows'
end

#* raw_term.rb - Platform determination for raw terminal access.
module MiniReadline
  #Get an instance of a raw terminal controller object.
  BASE_OPTIONS[:term] = RawTerm.new

end
