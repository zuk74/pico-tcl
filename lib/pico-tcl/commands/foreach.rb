
module PicoTcl
  class Interp
    def command_foreach args
      raise "Syntax Error, list" unless args.size == 3
# TODO: only one iter support
      set_var(args[0], "")
      s = PicoTcl::Scanner.new erase_bracket(args[1])
      s.each_list do |n|
        set_var(args[0], expand_all(n.to_s))
        self.eval(erase_bracket(args[2]))
      end
    end
  end
end


