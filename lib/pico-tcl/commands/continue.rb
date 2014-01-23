
module PicoTcl
  class Interp
    def command_continue args
      raise "Syntax Error, command continue" unless args.size == 0
      raise "invoked \"continue\" outside of a loop" unless @loop_depth > 0
      @tcl_continue = true
      ""
    end
  end
end


