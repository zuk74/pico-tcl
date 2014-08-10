$:.unshift File.dirname(__FILE__) + "../lib"
require 'pico-tcl'

describe PicoTcl::Interp do

  it "append0" do
    ip = PicoTcl::Interp.new
    ip.eval("set b {hoge}")
    expect( ip.eval("append a {hello}") ).to eq "hello"
    expect( ip.eval("append a $b") ).to eq "hellohoge"
    expect( ip.eval("append a nnn") ).to eq "hellohogennn"
  end

  it "append1" do
    ip = PicoTcl::Interp.new
    expect( ip.eval("append a {hello} { hogehoge}") ).to eq "hello hogehoge"
  end
end
