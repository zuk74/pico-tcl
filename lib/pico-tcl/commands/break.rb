
module PicoTcl
  class Interp
    def command_break args
      raise "Syntax Error, while" unless args.size == 0
      @tcl_break = true
      ""
    end
  end
end

