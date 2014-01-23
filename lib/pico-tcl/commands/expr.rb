
module PicoTcl
  class Interp
    def command_expr args
      if bracket?(args[0])
        raise "TODO: can't support yet, \"{...}\""
      end
      val = top_eval replace_var(
        args.map{|x| replace_brace(x)}.join("") )
      val.to_s
    end
  end
end


