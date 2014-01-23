$:.unshift File.dirname(__FILE__) + "../lib"
require 'pico-tcl'

describe PicoTcl::Interp do

  it "comment0" do
    ip = PicoTcl::Interp.new
    ip.eval("
        # comment
        set a 10
        ").should == "10"
    ip.eval("set b $a").should == "10"
  end


  it "comment1" do
    ip = PicoTcl::Interp.new
    ip.eval("
        set a 10 #  comment
        ").should == "10"
    ip.eval("set b $a").should == "10"
  end


end
