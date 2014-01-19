
class PicoTcl::Interp

  alias top_eval :eval

  def initialize
    @variables = {}
  end
  attr_reader :variables

  def eval text
    ret_code = ""
    s = PicoTcl::Scanner.new text
    s.get_commands do |line|
      cmd = line.shift
#      puts "command #{cmd}"
      ret_code = send("command_#{cmd}".to_sym, line)
    end
    ret_code = "" until ret_code
    ret_code
  end

  def replace_brace text
    text.gsub(/\[(.*)\]/m) do
      self.eval($1)
    end
  end

  def replace_var text
    ret_text = text.dup
    @variables.each do |k,v|
      ret_text.gsub!(/\$#{k}/, v)
    end
    ret_text
  end

  def expand_all text
    case text
    when /^{(.*)}$/m
      $1
    else
      replace_var(replace_brace(text))
    end
  end

  def bracket? text
    text.match(/^{.*}$/m)
  end

  def command_set args
    raise "error" until args.size == 2
    @variables[args[0].to_sym] = expand_all(args[1])
  end

  def command_expr args
    top_eval replace_var(
      args.map{|x| replace_brace(x)}.join("") )
  end

  def command_puts args
    raise "error" until args.size == 1
    ret = expand_all(args[0])
    puts ret
    ret
  end

  def command_if args
    raise "error" until args.size >= 2 and args.size%3 != 0
    if args.size > 2
      2.step(args.size,3) do |n|
        if n+2 < args.size #elseif
          raise "error elseif" until args[n] == "elseif"
        else #else
          raise "error else" until args[n] == "else"
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

end

