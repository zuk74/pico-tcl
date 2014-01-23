
class PicoTcl::Interp

  alias top_eval :eval

  def initialize
    @variables = {}
    @val_stack = [@variables]
    @loop_depth = 0
    @loop_stack = [@loop_depth]
    @tcl_break = false
    @tcl_return = nil
    @tcl_continue = false
  end
  attr_reader :variables

  def eval text
    ret_code = ""
    @tcl_return = nil
    @tcl_break = false
    s = PicoTcl::Scanner.new text
    s.each_command do |line|
      cmd = line.shift
#      puts "command #{cmd} -- #{line}"
      next if @tcl_continue
      ret_code = send("command_#{cmd}".to_sym, line)
      break if @tcl_break
      if @tcl_return
        ret_code = @tcl_return
        break
      end
    end
    ret_code = "" unless ret_code
    ret_code
  end

  def replace_brace text
    text.gsub(/\[(.*)\]/m) do
      self.eval($1)
    end
  end

  def stack_push
    @val_stack.push @variables
    @variables = {}
    @loop_stack.push @loop_depth
    @loop_depth = 0
  end

  def stack_pop
    @variables = nil
    @variables = @val_stack.pop
    @loop_depth = @loop_stack.pop
  end

  def replace_var text
    ret_text = text.dup
    @variables.each do |k,v|
      ret_text.gsub!(/\$#{k}\b|\${#{k}}/, v)
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

  def expand_condition text
    top_eval( expand_all(erase_bracket(text)) )
  end

  def bracket? text
    text.match(/^{.*}$/m)
  end

  def erase_bracket text
    if text =~ /^{(.*)}$/m
      $1
    else
      text
    end
  end

  def find_var?(name)
    @variables.key?(name.to_sym)
  end

  def set_var name, val
    @variables[name.to_sym] = val
  end

  def get_var name
    unless find_var?(name)
      raise "Error can not found variable #{name.inspect}"
    end
    @variables[name.to_sym]
  end

end

