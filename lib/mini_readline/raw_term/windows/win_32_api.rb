# coding: utf-8

#* windows/win_32_api.rb - Support for selected low level Win32 API entry points.
module MiniReadline

  require 'fiddle'

  #The classic \Win32API gem is deprecated, so we emulate it with fiddle.
  class Win32API
    #A hash of DLL files used for one or more API entry points.
    DLL = {}

    #Type mappings.
    TYPES = {"0" => Fiddle::TYPE_VOID,
             "S" => Fiddle::TYPE_VOIDP,
             "I" => Fiddle::TYPE_LONG}

    #Set up an API entry point.
    def initialize(dllname, func, import)
      @proto = import.join.tr("VPpNnLlIi", "0SSI").chomp('0').split('')

      handle = DLL[dllname] ||= Fiddle.dlopen(dllname)

      @func = Fiddle::Function.new(handle[func], TYPES.values_at(*@proto), 1)
    end

    #Call the Win 32 API entry point with appropriate arguments.
    #<br>Endemic Code Smells
    #* :reek:FeatureEnvy
    def call(*args)
      args.each_with_index do |arg, index|
        case @proto[index]
          when "S"
            args[index], = [arg == 0 ? nil : arg].pack("p").unpack("l!*")
          when "I"
            args[index], = [arg].pack("I").unpack("i")
        end
      end

      @func.call(*args).to_i || 0
    end
  end
end
