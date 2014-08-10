$:.unshift File.dirname(__FILE__) + "../lib"
require 'pico-tcl'
require 'stringio'

describe PicoTcl::Interp do

  it "put" do
    ip = PicoTcl::Interp.new
    str = ""
    $stdout = StringIO.new(str)
    expect( ip.eval("puts {hello}") ).to eq ""
    expect( str ).to eq "hello\n"
    $stdout = STDOUT
  end
end

