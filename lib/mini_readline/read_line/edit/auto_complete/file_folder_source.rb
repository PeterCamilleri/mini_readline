# coding: utf-8

#* file_folder_source.rb - The data source for auto-complete.
module MiniReadline

  #* file_folder_source.rb - The data source for auto-complete.
  class FileFolderSource

    #Construct a new data list for auto-complete
    def rebuild(pivot)
      list = Dir.glob(pivot + '*')

      unless list.empty?
        list.cycle
      else
        nil
      end
    end

  end

end
