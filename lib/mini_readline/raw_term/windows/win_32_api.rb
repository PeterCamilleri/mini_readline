# coding: utf-8

#* windows/win_32_api.rb - Support for selected low level Win32 API entry points.
module MiniReadline

  require 'dl'

  #The classic \Win32API gem is deprecated, so we emulate it with DL.
  class Win32API

    #A hash of DLL files used for one or more API entry points.
    DLL = {}

    #Type mappings
    TYPEMAP = {"0" => DL::TYPE_VOID, "S" => DL::TYPE_VOIDP, "I" => DL::TYPE_LONG}

    #Set up an API entry point.
    def initialize(dllname, func, import, export = "0", calltype = :stdcall)
      @proto = [import].join.tr("VPpNnLlIi", "0SSI").sub(/^(.)0*$/, '\1')
      handle = DLL[dllname] ||= DL.dlopen(dllname)
      @func  = DL::CFunc.new(handle[func], TYPEMAP[export.tr("VPpNnLlIi", "0SSI")], func, calltype)
    end

    #Call the Win 32 API entry point with appropriate arguments.
    #<br>Endemic Code Smells
    #* :reek:TooManyStatements - I ain't messin' with this crap!
    def call(*args)
      import = @proto.split("")

      args.each_with_index do |value, index|
        case @proto[index]
          when "S"
            args[index], = [value == 0 ? nil : value].pack("p").unpack("l!*")
          when "I"
            args[index], = [value].pack("I").unpack("i")
        end
      end

      ret, = @func.call(args)
      return ret || 0
    end

  end
end
