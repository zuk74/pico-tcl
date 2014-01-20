$:.unshift File.dirname(__FILE__) + "../lib"
require 'pico-tcl'

describe PicoTcl::Interp do

  it "val0" do
    ip = PicoTcl::Interp.new
    ip.eval("set aa 10").should == "10"
    ip.eval("set a 30").should == "30"
    ip.eval("set val $a").should == "30"
    ip.eval("set val $aa").should == "10"
  end

  it "val1" do
    ip = PicoTcl::Interp.new
    ip.eval("set a 30").should == "30"
    ip.eval("set aa 10").should == "10"
    ip.eval("set val $a").should == "30"
    ip.eval("set val $aa").should == "10"
  end

  it "val1" do
    ip = PicoTcl::Interp.new
    ip.eval("set abc 30").should == "30"
    ip.eval("set val ${abc}").should == "30"
  end



end

