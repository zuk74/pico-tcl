$:.unshift File.dirname(__FILE__) + "../lib"
require 'pico-tcl'

describe PicoTcl::Interp do

  it "foreach0" do
    ip = PicoTcl::Interp.new
    ip.eval("set a 0").should == "0"
    ip.eval("incr a").should == "1"
    ip.eval("incr a").should == "2"
    ip.eval("incr a").should == "3"
    ip.eval("incr a 5").should == "8"
    ip.eval("incr a 5").should == "13"
  end
end

