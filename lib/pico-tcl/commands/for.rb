
module PicoTcl
  class Interp
    def command_for args
      raise "Syntax Error, command for" unless args.size == 4
      @loop_depth += 1
      self.eval( expand_all(args[0]) )
      while expand_condition( args[1] ) and !@tcl_break
        self.eval( expand_all(args[3]) )
        @tcl_continue = false
        self.eval( expand_all(args[2]) )
      end
      @tcl_break = false
      @loop_depth -= 1 if @loop_depth > 0
      ""
    end
  end
end


