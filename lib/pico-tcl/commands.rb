

class PicoTcl::Interp

  def command_exit args
    exit
  end

  def command_set args
    raise "Syntax Error, commnd set" until args.size == 2
    @variables[args[0].to_sym] = expand_all(args[1])
  end

  def command_expr args
    top_eval replace_var(
      args.map{|x| replace_brace(x)}.join("") )
  end

  def command_puts args
    raise "Syntax Error, command puts" until args.size == 1
    ret = expand_all(args[0])
    puts ret
    ret
  end

  def command_if args
    raise "Syntax Error, command if" until
        args.size >= 2 and args.size%3 != 0
    if args.size > 2
      2.step(args.size,3) do |n|
        if n+2 < args.size #elseif
          raise "Syntax Error, elseif" until args[n] == "elseif"
        else #else
          raise "Syntax Error, else" until args[n] == "else"
        end
      end
    end
    if top_eval( expand_all(expand_all(args[0])) )
      return self.eval( expand_all(args[1]) )
    end
    if args.size > 2
      2.step(args.size,3) do |n|
        if n+2 < args.size #elseif
#          raise "error elseif" until args[n] == "elseif"
          if top_eval( expand_all(expand_all(args[n+1])) )
            return self.eval( expand_all(args[n+2]) )
          end
        else #else
#          raise "error else" until args[n] == "else"
          return self.eval( expand_all(args[n+1]) )
        end
      end
    end
  end

  def command_while args
    raise "Syntax Error, while" until args.size == 2
    @tcl_break = false
    while top_eval( expand_all(expand_all(args[0])) ) and !@tcl_break
      self.eval( expand_all(args[1]) )
    end
    @tcl_break = false
    ""
  end

  def command_break args
    raise "Syntax Error, while" until args.size == 0
    @tcl_break = true
    ""
  end

  def command_proc args
    raise "Syntax Error, proc" until args.size == 3
    arg_names = expand_all(args[1]).split(/\s+/)
    instance_eval %Q{
      def command_#{args[0]} args
        raise "Syntax Error, command #{args[0]}" until args.size == #{arg_names.size}
        val_push
        #{arg_names.to_s}.each_with_index do |name,i|
          @variables[ name ] = args[i]
        end
        self.eval( expand_all(#{args[2].inspect}) )
        val_pop
      end
    }  
  end

  def command_return args
    raise "Syntax Error, return" until args.size <= 1
    if args.size == 1
      @tcl_return = expand_all(args[0])
    else
      @tcl_return = ""
    end
  end

  def command_list args
    raise "Syntax Error, list" until args.size >= 1
    rets = []
    args.each do |n|
      unless bracket?(n)
        n = expand_all(n)
        n = "{"+n+"}" if n =~ /\s+/
      end
      rets << n
    end
    rets.join(" ")
  end

  def method_missing(action, *args)
    if action.to_s =~ /command_(.+)/
      raise "Error, undefined method #{$1.inspect}"
    else
      raise "Error, undefined method #{action.inspect}"
    end
  end

end
