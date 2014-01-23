
module PicoTcl
  class Interp

    def method_missing(action, *args)
      if action.to_s =~ /command_(.+)/
        raise "Error, undefined method #{$1.inspect}"
      else
        raise "Error, undefined method #{action.inspect}"
      end
    end

  end
end

require 'pico-tcl/commands/exit'
require 'pico-tcl/commands/set'
require 'pico-tcl/commands/expr'
require 'pico-tcl/commands/puts'
require 'pico-tcl/commands/if'
require 'pico-tcl/commands/while'
require 'pico-tcl/commands/break'
require 'pico-tcl/commands/proc'
require 'pico-tcl/commands/return'
require 'pico-tcl/commands/list'
require 'pico-tcl/commands/foreach'
require 'pico-tcl/commands/incr'
require 'pico-tcl/commands/for'
require 'pico-tcl/commands/continue'
require 'pico-tcl/commands/append'


