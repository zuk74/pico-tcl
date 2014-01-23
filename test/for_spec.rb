$:.unshift File.dirname(__FILE__) + "../lib"
require 'pico-tcl'

describe PicoTcl::Interp do

  it "for0" do
    ip = PicoTcl::Interp.new
    ip.eval("set a {}")
    ip.eval("
        for {set i 0} {$i < 5} {incr i} {
          set a \"$a,$i\"
        }
        set val $a
    ").should == ",0,1,2,3,4"
  end

  it "for-break" do
    ip = PicoTcl::Interp.new
    ip.eval("set a {}")
    ip.eval("
        for {set i 0} {$i < 5} {incr i} {
          if {$i > 3} {
            break
          }
          set a \"$a,$i\"
        }
        set val $a
    ").should == ",0,1,2,3"
  end

end

