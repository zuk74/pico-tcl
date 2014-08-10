$:.unshift File.dirname(__FILE__) + "../lib"
require 'pico-tcl'

describe PicoTcl::Interp do

  it "foreach0" do
    ip = PicoTcl::Interp.new
    expect( ip.eval("set a 0") ).to eq "0"
    expect( ip.eval("incr a") ).to eq "1"
    expect( ip.eval("incr a") ).to eq "2"
    expect( ip.eval("incr a") ).to eq "3"
    expect( ip.eval("incr a 5") ).to eq "8"
    expect( ip.eval("incr a 5") ).to eq "13"
  end
end

