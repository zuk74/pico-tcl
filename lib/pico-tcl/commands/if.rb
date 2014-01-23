
module PicoTcl
  class Interp
    def command_if args
      raise "Syntax Error, command if" unless
          args.size >= 2 and args.size%3 != 0
      if args.size > 2
        2.step(args.size,3) do |n|
          if n+2 < args.size #elseif
            raise "Syntax Error, elseif" unless args[n] == "elseif"
          else #else
            raise "Syntax Error, else" unless args[n] == "else"
          end
        end
      end
      if expand_condition( args[0] )
        return self.eval( expand_all(args[1]) )
      end
      if args.size > 2
        2.step(args.size,3) do |n|
          if n+2 < args.size #elseif
#          raise "error elseif" unless args[n] == "elseif"
            if expand_condition( args[n+1] )
              return self.eval( expand_all(args[n+2]) )
            end
          else #else
#          raise "error else" unless args[n] == "else"
            return self.eval( expand_all(args[n+1]) )
          end
        end
      end
    end
  end
end


