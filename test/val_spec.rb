$:.unshift File.dirname(__FILE__) + "../lib"
require 'pico-tcl'

describe PicoTcl::Interp do

  it "val0" do
    ip = PicoTcl::Interp.new
    expect( ip.eval("set aa 10") ).to eq "10"
    expect( ip.eval("set a 30") ).to eq "30"
    expect( ip.eval("set val $a") ).to eq "30"
    expect( ip.eval("set val $aa") ).to eq "10"
  end

  it "val1" do
    ip = PicoTcl::Interp.new
    expect( ip.eval("set a 30") ).to eq "30"
    expect( ip.eval("set aa 10") ).to eq "10"
    expect( ip.eval("set val $a") ).to eq "30"
    expect( ip.eval("set val $aa") ).to eq "10"
  end

  it "val1" do
    ip = PicoTcl::Interp.new
    expect( ip.eval("set abc 30") ).to eq "30"
    expect( ip.eval("set val ${abc}") ).to eq "30"
  end



end

