$:.unshift File.dirname(__FILE__) + "../lib"
require 'pico-tcl'

describe PicoTcl::Interp do
  it "while1" do
    ip = PicoTcl::Interp.new
    expect( ip.eval("set a 0") ).to eq "0"
    expect( ip.eval("
        while { $a < 10 } {
          set a [expr $a + 1]
        }
        set b $a
      ") ).to eq "10"
  end

  it "while2" do
    ip = PicoTcl::Interp.new
    expect( ip.eval("set a 0") ).to eq "0"
    expect( ip.eval("
        while { $a < 10 } {
          set a [expr $a + 1]
          if { $a == 5 } {
            break
          }
        }
        set b $a
      ") ).to eq "5"
  end

  it "while3" do
    ip = PicoTcl::Interp.new
    expect( ip.eval("set a 0") ).to eq "0"
    expect( ip.eval("
        while { $a < 10 } {
          if { $a == 5 } {
            break
          }
          set a [expr $a + 1]
        }
        set b $a
      ") ).to eq "5"
  end

  it "while4" do
    ip = PicoTcl::Interp.new
    expect( ip.eval("set a 0") ).to eq "0"
    expect( ip.eval("
        set c 0
        while { $a < 10 } {
          set d 0
          while { true } {
            if { $d == 2 }  {
              break
            }
            set c [expr $c + 1]
            set d [expr $d + 1]
          }

          if { $a == 8 } {
            break
          }
          set a [expr $a + 1]
        }
        set b $c
      ") ).to eq "18"
  end

end
