$:.unshift File.dirname(__FILE__) + "../lib"
require 'pico-tcl'
require 'stringio'

describe PicoTcl::Interp do

  it "put" do
    ip = PicoTcl::Interp.new
    str = ""
    $stdout = StringIO.new(str)
    ip.eval("puts {hello}").should == ""
    str.should == "hello\n"
    $stdout = STDOUT
  end
end

