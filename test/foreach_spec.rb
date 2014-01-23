$:.unshift File.dirname(__FILE__) + "../lib"
require 'pico-tcl'

describe PicoTcl::Interp do

  it "foreach0" do
    ip = PicoTcl::Interp.new
    ip.eval("set a {}").should == ""
    ip.eval("
        foreach i {a b c d e f} {
          set a \"$i,$a\"
        }
    ").should == ""
    ip.eval("set val $a").should == "f,e,d,c,b,a,"
  end

end
