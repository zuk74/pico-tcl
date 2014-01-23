$:.unshift File.dirname(__FILE__) + "../lib"
require 'pico-tcl'

describe PicoTcl::Interp do

  it "expr0" do
    ip = PicoTcl::Interp.new
    ip.eval("expr 10*10").should == "100"
  end

  it "expr1" do
    ip = PicoTcl::Interp.new
    ip.eval("set a [expr [expr 20 + 10] * [expr 10]]").should == "300"
  end


end

