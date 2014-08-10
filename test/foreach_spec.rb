$:.unshift File.dirname(__FILE__) + "../lib"
require 'pico-tcl'

describe PicoTcl::Interp do

  it "foreach0" do
    ip = PicoTcl::Interp.new
    expect( ip.eval("set a {}") ).to eq ""
    expect( ip.eval("
        foreach i {a b c d e f} {
          set a \"$i,$a\"
        }
    ") ).to eq ""
    expect( ip.eval("set val $a") ).to eq "f,e,d,c,b,a,"
  end

end
