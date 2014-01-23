
module PicoTcl
  class Interp
    def command_incr args
      raise "Syntax Error, command incr" unless
         args.size == 1 or args.size == 2
      inc = 1
      if args.size == 2
        unless args[1] =~ /[+-]?\d+/
          raise "Error, expected integer but got #{args[1].inspect}"
        end
        inc = args[1].to_i
      end

      val_name = args[0]
      val = "0"
      if @variables.key?(val_name.to_sym)
        val = get_var(val_name)
        unless val =~ /[+-]?\d+/
          raise "Error, expected integer but got #{val.inspect}"
        end
      end
      set_var(val_name, (val.to_i + inc).to_s )
    end
  end
end
 
