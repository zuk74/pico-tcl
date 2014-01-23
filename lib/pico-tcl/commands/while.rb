
module PicoTcl
  class Interp
    def command_while args
      raise "Syntax Error, while" unless args.size == 2
      @tcl_break = false
      @loop_depth += 1
      while expand_condition( args[0] ) and !@tcl_break
        self.eval( expand_all(args[1]) )
        @tcl_continue = false
      end
      @tcl_break = false
      @loop_depth -= 1 if @loop_depth > 0
      ""
    end
  end
end


