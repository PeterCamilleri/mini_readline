# coding: utf-8

# An array as the source for auto-complete.
module MiniReadline

  # An array as the source for auto-complete.
  class ArraySource

    # Create a new file/folder auto-data source. NOP
    def initialize(options)
      @options = options
    end

    # Construct a new data list for auto-complete
    def rebuild(str)
      extract_root_pivot(str)

      list = (get_array.select {|entry| entry.start_with?(@pivot)}).sort

      @cycler = list.empty? ? nil : list.cycle
    end

    # Parse the string into the two basic components.
    def extract_root_pivot(str)
      @root, @pivot = /\S+$/ =~ str ? [$PREMATCH, $MATCH] : [str, ""]
    end

    # Get the array of data from either an array or a block.
    def get_array
      if (src = @options[:array_src]).is_a?(Proc)
        src.call
      else
        src || []
      end
    end

    # Get the next string for auto-complete
    def next
      @root + @cycler.next
    end

  end

end
