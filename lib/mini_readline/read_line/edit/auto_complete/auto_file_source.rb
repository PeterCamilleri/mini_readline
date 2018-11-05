# coding: utf-8

# The data source for mysh file name auto-complete.
module MiniReadline

  # A flexible file source for shell emulation.
  class AutoFileSource

    # Create a new file/folder auto-data source. NOP
    def initialize(_options)
      #Do nothing here!
    end

    # Construct a new data list for auto-complete
    def rebuild(str)
      extract_root_pivot(str)

      list = Dir.glob(dress_down(@pivot) + '*')

      @cycler = list.empty? ? nil : list.cycle
    end

    # The regex for extraction of the root and pivot.
    EXTRACT = /("[^"\s][^"]*"?$)|(\S+$)/

    # Parse the string into the two basic components.
    def extract_root_pivot(str)
      @root, @pivot = EXTRACT =~ str ? [$PREMATCH, $MATCH] : [str, ""]
    end

    # Get the next string for auto-complete
    def next
      @root + dress_up(@cycler.next)
    end

    # Prepare the file name for internal use.
    # Endemic Code Smells
    # :reek:UtilityFunction
    def dress_down(name)
      name.gsub("\\", "/").gsub('"', '')
    end

    # Prepare the file name for external use.
    # Endemic Code Smells
    # :reek:UtilityFunction
    def dress_up(name)
      dress_up_quotes(dress_up_slashes(name))
    end

    # Dress up slashes and backslashes.
    def dress_up_slashes(name)
      backslash? ? name.gsub("/", "\\") : name
    end

    # Dress up in quotes if needed.
    # Endemic Code Smells
    # :reek:UtilityFunction
    def dress_up_quotes(name)
      name[' '] ? "\"#{name}\"" : name
    end

    # Does this file name use backslashes?
    def backslash?
      if @pivot.end_with?("\\")
        true
      elsif @pivot.end_with?("/")
        false
      elsif @pivot["\\"]
        true
      elsif @pivot["/"]
        false
      else
        MiniTerm.windows?
      end
    end

  end

end
