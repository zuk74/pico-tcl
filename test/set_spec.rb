$:.unshift File.dirname(__FILE__) + "../lib"
require 'pico-tcl'

describe PicoTcl::Interp do

  it "set" do
    ip = PicoTcl::Interp.new
    ip.eval("set a 10").should == "10"
    ip.eval("set b 30").should == "30"
    ip.eval("set c 30; set d 40").should == "40"
  end

  it "set2" do
    ip = PicoTcl::Interp.new
    ip.eval("set a aaa{bbb}").should == "aaa{bbb}"
    ip.eval("set a aaa{bbb").should == "aaa{bbb"
    ip.eval("set a ccc").should == "ccc"
    ip.eval("set a {ddd}").should == "ddd"
  end

  it "eval0" do
    ip = PicoTcl::Interp.new
    ip.eval("
        set a 10
        set b 20
        set c [expr $a * $b]
    ").should == "200"
  end

  it "eval1" do
    ip = PicoTcl::Interp.new
    ip.eval("set a {10 + 10}").should == "10 + 10"
    ip.eval("set b [expr 10 * $a]").should == "110"
  end

#  it "eval2" do
#    ip = PicoTcl::Interp.new
#    ip.eval("set a [expr 10*{20}]").should == "200"
#  end

end

