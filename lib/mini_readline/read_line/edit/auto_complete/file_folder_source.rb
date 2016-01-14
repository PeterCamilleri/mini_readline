# coding: utf-8

#* file_folder_source.rb - The data source for auto-complete.
module MiniReadline

  #* file_folder_source.rb - The data source for auto-complete.
  class FileFolderSource

    #Construct a new data list for auto-complete
    def rebuild(str)
      @root, pivot = /\S+$/ =~ str ? [$`.to_s, $~.to_s] : [str, ""]

      list = Dir.glob(pivot + '*')

      unless list.empty?
        @cycler = list.cycle
      else
        false
      end
    end

    #Get the next string for auto-complete
    def next
      @root + @cycler.next
    end

  end

end
