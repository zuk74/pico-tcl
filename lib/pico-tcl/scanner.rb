require 'strscan'

class PicoTcl::Scanner < StringScanner
  def initialize text
    super(text)
  end

  def get_bracket sr=/{/, er=/}/
    ss = self
    level = 0
    start_p = ss.pos
    until ss.eos?
      case
      when ss.scan(/#.+$/)
        #nothing
      when ss.scan(sr)
        level += 1
      when ss.scan(er)
        if level == 0
          end_p = ss.pos-2
          return ss.string[start_p..end_p]
        end
        level -= 1
#      when ss.scan(/[^\\]\n/m)
#        end_p = ss.pos-2
#        raise "Syntax Error, closed \"]\"\n"+"#{ss.string[(start_p-1)..end_p]}"
      when ss.scan(/./m)
        #nothing
      end
    end
    raise "error"
  end

  def get_token
    ss = self
    until ss.eos?
      case
      when ss.scan(/;|\n/)
        return {type: :sep, str: ss[0]}
      when ss.scan(/([ \t]|\\\n)+/)
        return {type: :space, str: ss[0]}
      when ss.scan(/${.+}/)
        return {type: :literal, str: ss[0]}
      when ss.scan(/#(.*)$/)
        return {type: :comment, str: ss[1]}
      when ss.scan(/"(.*)"/m)
        return {type: :literal, str: ss[1]}
      when ss.scan(/\{/)
        return {type: :brace, str: "{"+get_bracket(/{/, /}/)+"}"}
      when ss.scan(/\[/)
        return {type: :bracket, str: "["+get_bracket(/\[/, /\]/)+"]"}
      when ss.scan(/[^#;\[\"\s]+/)
        return {type: :literal, str: ss[0]}
      else
        raise "can't parse #{ss}"
      end
    end
    return {type: :eos, str: nil}
  end

  def each_token
    loop do
      token = get_token
      break if token[:type] == :eos
      unless token[:type] == :comment
        yield(token[:type],token[:str])
      end
    end
  end

  def each_command
    command_list = []
    loop do
      args = []
      token = nil
      loop do
        token = get_token
        break if token[:type] == :eos
        break if token[:type] == :sep and args.size != 0
        unless token[:type] == :space or token[:type] == :sep or token[:type] == :comment
          args << token[:str]
        end
      end
      break if args.size == 0
      command_list << args
    end
#    p command_list
    if block_given?
      command_list.each do |line|
        yield(line)
      end
    end
    command_list
  end

  def each_list
    each_token do |type,str|
      next if (type == :sep and str != ";") or
              type == :space
      yield(str)
    end
  end
end

