# coding: utf-8

#* quoted_file_folder_source.rb - The data source for auto-complete.
module MiniReadline

  #* quoted_file_folder_source.rb - The data source for auto-complete.
  class QuotedFileFolderSource

    #Create a new file/folder auto-data source. NOP
    def initialize(_options); end

    #Construct a new data list for auto-complete
    def rebuild(str)
      extract_root_pivot(str)

      list = Dir.glob(@pivot + '*')

      @cycler = list.empty? ? nil : list.cycle
    end

    #The parsing regular expression.
    REGEX = /(?<=\")([^\"\s][^\"]*)?(?=\"?$)/

    #Parse the string into the two basic components.
    def extract_root_pivot(str)
      @root, @pivot = REGEX =~ str ? [$PREMATCH, $MATCH] : [str + '"', ""]
    end

    #Get the next string for auto-complete
    def next
      "#{@root}#{@cycler.next}\""
    end

  end

end
