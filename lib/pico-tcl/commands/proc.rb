
module PicoTcl
  class Interp
    def command_proc args
      raise "Syntax Error, proc" unless args.size == 3
# TODO: can't support variable arguments -- args
      arg_names = expand_all(args[1]).split(/\s+/)
      instance_eval %Q{
        def command_#{args[0]} args
          raise "Syntax Error, command #{args[0]}" unless args.size == #{arg_names.size}
          stack_push
          #{arg_names.to_s}.each_with_index do |name,i|
            @variables[ name ] = args[i]
          end
          self.eval( expand_all(#{args[2].inspect}) )
          stack_pop
        end
      }  
    end
  end
end


