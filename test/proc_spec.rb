$:.unshift File.dirname(__FILE__) + "../lib"
require 'pico-tcl'

describe PicoTcl::Interp do

  it "proc0" do
    ip = PicoTcl::Interp.new
    ip.eval("
        proc calc {} {
          return 10
        }
        set val [calc]
    ").should == "10"
  end

  it "proc1" do
    ip = PicoTcl::Interp.new
    ip.eval("
        proc calc {a b c} {
          set n [expr $a * $b + $c]
          return $n
        }
        set val [calc 10 20 30]
    ").should == "230"
  end

  it "proc2" do
    ip = PicoTcl::Interp.new
    ip.eval("
        proc calc {} {
          return
        }
        set val [calc]
    ").should == ""
  end



end
