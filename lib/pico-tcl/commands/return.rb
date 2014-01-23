
module PicoTcl
  class Interp
    def command_return args
      raise "Syntax Error, return" unless args.size <= 1
      if args.size == 1
        @tcl_return = expand_all(args[0])
      else
        @tcl_return = ""
      end
    end
  end
end

