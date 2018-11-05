# coding: utf-8

# The controller for auto-complete.
module MiniReadline

  # The controller for auto-complete.
  class AutoManager

    # Create a new auto-complete manager.
    def initialize(&block)
      @_block = block
      @active = nil
    end

    # Get the next buffer string
    def next(buffer)
      unless @active && @old_buffer == buffer
        @active = source.rebuild(buffer)
      end

      if @active
        @old_buffer = source.next
      else
        @old_buffer = nil
      end
    end

    # Get the data source
    def source
      @_source ||= @_block.call
    end
  end

end
