
module PicoTcl
  class Interp
    def command_set args
      raise "Syntax Error, commnd set" unless args.size == 2
      set_var( args[0], expand_all(args[1]) )
    end
  end
end

