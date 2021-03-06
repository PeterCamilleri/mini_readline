# coding: utf-8

# The data source for auto-complete.
module MiniReadline

  # The data source for auto-complete.
  class FileFolderSource

    # Create a new file/folder auto-data source. NOP
    def initialize(_options); end

    # Construct a new data list for auto-complete
    def rebuild(str)
      extract_root_pivot(str)

      list = Dir.glob(@pivot + '*')

      @cycler = list.empty? ? nil : list.cycle
    end

    # Parse the string into the two basic components.
    def extract_root_pivot(str)
      @root, @pivot = /\S+$/ =~ str ? [$PREMATCH, $MATCH] : [str, ""]
    end

    # Get the next string for auto-complete
    def next
      @root + @cycler.next
    end

  end

end
