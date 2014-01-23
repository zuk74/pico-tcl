
module PicoTcl
  class Interp
    def command_puts args
      raise "Syntax Error, command puts" unless args.size == 1
      ret = expand_all(args[0])
      puts ret
      ""
    end
  end
end


