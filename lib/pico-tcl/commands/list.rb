
module PicoTcl
  class Interp
    def command_list args
      raise "Syntax Error, list" unless args.size >= 1
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
  end
end


