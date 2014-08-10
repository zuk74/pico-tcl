$:.unshift File.dirname(__FILE__) + "../lib"
require 'pico-tcl'

describe PicoTcl::Interp do

  it "set" do
    ip = PicoTcl::Interp.new
    expect( ip.eval("set a 10") ).to eq "10"
    expect( ip.eval("set b 30") ).to eq "30"
    expect( ip.eval("set c 30; set d 40") ).to eq "40"
  end

  it "set2" do
    ip = PicoTcl::Interp.new
    expect( ip.eval("set a aaa{bbb}") ).to eq "aaa{bbb}"
    expect( ip.eval("set a aaa{bbb") ).to eq "aaa{bbb"
    expect( ip.eval("set a ccc") ).to eq "ccc"
    expect( ip.eval("set a {ddd}") ).to eq "ddd"
  end

  it "eval0" do
    ip = PicoTcl::Interp.new
    expect( ip.eval("
        set a 10
        set b 20
        set c [expr $a * $b]
    ") ).to eq "200"
  end

  it "eval1" do
    ip = PicoTcl::Interp.new
    expect( ip.eval("set a {10 + 10}") ).to eq "10 + 10"
    expect( ip.eval("set b [expr 10 * $a]") ).to eq "110"
  end

#  it "eval2" do
#    ip = PicoTcl::Interp.new
#    expect( ip.eval("set a [expr 10*{20}]") ).to eq "200"
#  end

end

