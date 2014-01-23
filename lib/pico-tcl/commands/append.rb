
module PicoTcl
  class Interp
    def command_append args
      raise "Syntax Error, command append" unless args.size >= 2
      name = args[0]
      unless find_var?(name)
        set_var(name, "")
      end
      args[1..-1].each do |l|
        set_var( name, get_var(name)+expand_all(l) )
      end
      get_var(name)
    end
  end
end
