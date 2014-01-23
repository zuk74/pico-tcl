$:.unshift File.dirname(__FILE__) + "../lib"
require 'pico-tcl'

describe PicoTcl::Interp do

  it "append0" do
    ip = PicoTcl::Interp.new
    ip.eval("set b {hoge}")
    ip.eval("append a {hello}").should == "hello"
    ip.eval("append a $b").should == "hellohoge"
    ip.eval("append a nnn").should == "hellohogennn"
  end

  it "append1" do
    ip = PicoTcl::Interp.new
    ip.eval("append a {hello} { hogehoge}").should == "hello hogehoge"
  end
end
