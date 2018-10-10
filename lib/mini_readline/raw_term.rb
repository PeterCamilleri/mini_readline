# coding: utf-8

require 'rbconfig'

#* raw_term.rb - Platform determination for raw terminal access.
module MiniReadline

  # :stopdoc:
  host_os = RbConfig::CONFIG['host_os']
  # :startdoc:

  #What operating platform is in effect?
  TERM_PLATFORM =
    case host_os
    when /mswin|msys|mingw|bccwin|wince|emc/
      :windows
    when /cygwin/
      :cygwin
    when /darwin|mac os/
      :macosx
    when /linux/
      :linux
    when /solaris|bsd/
      :unix
    else
      raise "Unknown os: #{host_os.inspect}"
    end

  #Is Java present in the environment?
  TERM_JAVA = RUBY_PLATFORM =~ /java/

  #Only install a terminal if one is not already provided.
  unless BASE_OPTIONS[:term]

    #Select the type of platform in use.
    if TERM_PLATFORM == :windows
      require_relative 'raw_term/windows'
    else
      require_relative 'raw_term/ansi'
    end

    #Get an instance of a raw terminal controller object.
    BASE_OPTIONS[:term] = RawTerm.new

  end

  # Get terminal column*row counts.
  def self.term_info
    BASE_OPTIONS[:term].term_info
  end

end
