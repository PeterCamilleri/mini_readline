# coding: utf-8

#* file_folder_source.rb - The data source for auto-complete.
module MiniReadline

  #* file_folder_source.rb - The data source for auto-complete.
  class FileFolderSource

    #Create a new file/folder auto-data source. NOP
    def initialize(_options)
    end

    #Construct a new data list for auto-complete
    def rebuild(str)
      @root, pivot = /\S+$/ =~ str ? [$`.to_s, $~.to_s] : [str, ""]

      list = Dir.glob(pivot + '*')

      unless list.empty?
        @cycler = list.cycle
      else
        @cycler = nil
      end
    end

    #Get the next string for auto-complete
    def next
      @root + @cycler.next
    end

  end

end
