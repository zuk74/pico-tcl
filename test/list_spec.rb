
$:.unshift File.dirname(__FILE__) + "../lib"
require 'pico-tcl'

describe PicoTcl::Interp do

  it "list0" do
    ip = PicoTcl::Interp.new
    ip.eval("list a b c d").should == "a b c d"
  end

  it "list1" do
    ip = PicoTcl::Interp.new
    ip.eval("list a {b c} d").should == "a {b c} d"
  end

  it "list2" do
    ip = PicoTcl::Interp.new
    ip.eval("list a \"b c\" d").should == "a {b c} d"
  end

  it "list3" do
    ip = PicoTcl::Interp.new
    ip.eval("set a 10")
    ip.eval("list a b $a c").should == "a b 10 c"
  end

  it "list3" do
    ip = PicoTcl::Interp.new
    ip.eval("set a 10")
    ip.eval("list a b [expr $a * 10] c").should == "a b 100 c"
  end




end

