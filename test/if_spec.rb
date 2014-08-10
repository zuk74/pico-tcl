$:.unshift File.dirname(__FILE__) + "../lib"
require 'pico-tcl'

describe PicoTcl::Interp do

  it "if0" do
    ip = PicoTcl::Interp.new
    expect( ip.eval("if { 10 < 20 } {
          set a 10
        }
    ") ).to eq "10"
  end

  it "if1" do
    ip = PicoTcl::Interp.new
    expect( ip.eval("if { 10 > 20 } {
          set a 10
        }
    ") ).to eq ""
  end

# TODO: 0 or 1
#  it "if2" do
#    ip = PicoTcl::Interp.new
#    ip.eval("if 1 {
#          set a 10
#        }
#    ").should == "10"
#  end
#
#  it "if3" do
#    ip = PicoTcl::Interp.new
#    ip.eval("if 0 {
#          set a 10
#        }
#    ").should == ""
#  end

  it "if-else2" do
    ip = PicoTcl::Interp.new
    ip.eval("set a 10")
    expect( ip.eval("if { $a < 20 } {
          set a 10
        } else {
          set a 20
        }
    ") ).to eq "10"
  end

  it "if-else1" do
    ip = PicoTcl::Interp.new
    ip.eval("set a 10")
    expect( ip.eval("if { $a < 5 } {
          set a 10
        } else {
          set a 20
        }
    ") ).to eq "20"
  end

  it "if-elseif-else" do
    ip = PicoTcl::Interp.new
    ip.eval("set a 10")
    expect( ip.eval("if { $a < 5 } {
          set a 10
        } elseif { $a > 5} {
          set a 50
        } else {
          set a 20
        }
    ") ).to eq "50"
  end

  it "if-elseif-else2" do
    ip = PicoTcl::Interp.new
    ip.eval("set a 10")
    expect( ip.eval("if { $a < 5 } {
          set a 10
        } elseif {$a == 5} {
          set a 50
        } elseif {$a > 5} {
          set a 100
        } else {
          set a 20
        }
    ") ).to eq "100"
  end

end
