$:.unshift File.dirname(__FILE__) + "../lib"
require 'pico-tcl'

describe PicoTcl::Interp do

  it "comment0" do
    ip = PicoTcl::Interp.new
    expect( ip.eval("
        # comment
        set a 10
        ") ).to eq "10"
    expect( ip.eval("set b $a") ).to eq "10"
  end


  it "comment1" do
    ip = PicoTcl::Interp.new
    expect( ip.eval("
        set a 10 #  comment
        ") ).to eq "10"
    expect( ip.eval("set b $a") ).to eq "10"
  end


end
