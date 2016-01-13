# coding: utf-8

#* auto_manager.rb - The controller for auto-complete.
module MiniReadline

  #* auto_manager.rb - The controller for auto-complete.
  class AutoManager

    #Create a new auto-complete manager.
    def initialize(&block)
      @_block = block
    end

    #Get the next pivot string
    def next(pivot)
      unless @cycler && @old_pivot == pivot
        @cycler = source.rebuild(pivot)
      end

      if @cycler
        @old_pivot = @cycler.next
      else
        @old_pivot = nil
      end
    end

    #Get the data source
    def source
      @_source ||= @_block.call
    end
  end

end
