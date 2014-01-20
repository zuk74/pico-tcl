$:.unshift File.dirname(__FILE__) + "../lib"
require 'pico-tcl'

describe PicoTcl::Interp do

  it "put" do
    ip = PicoTcl::Interp.new
    ip.eval("set a 10; set b 30").should == "30"
    ip.eval("puts \"$a $b\"").should == "10 30"
    ip.eval("puts {$a $b}").should == "$a $b"
  end
end

