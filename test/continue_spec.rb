$:.unshift File.dirname(__FILE__) + "../lib"
require 'pico-tcl'

describe PicoTcl::Interp do

  it "for-continue" do
    ip = PicoTcl::Interp.new
    ip.eval("set a {}")
    expect( ip.eval("
        for {set i 0} {$i < 5} {incr i} {
          if {$i < 3} {
            continue
          }
          set a \"$a,$i\"
        }
        set val $a
    ") ).to eq ",3,4"
  end

  it "for-while" do
    ip = PicoTcl::Interp.new
    ip.eval("set a {}")
    ip.eval("set i 0")
    expect( ip.eval("
        while {$i < 5}  {
          if {$i < 3} {
            incr i
            continue
          }
          set a \"$a,$i\"
          incr i
        }
        set val $a
    ") ).to eq ",3,4"

    ip.eval("set a {}")
    ip.eval("set i 1")
    expect( ip.eval("
        while {$i < 7}  {
          if {$i > 5} {
            incr i
            continue
          }
          set a \"$a,$i\"
          incr i
        }
        set val $a
    ") ).to eq ",1,2,3,4,5"

  end

  it "continue-error" do
    ip = PicoTcl::Interp.new
    str = ""
    begin
      ip.eval("continue")
    rescue => e
      str = e.message
    end
    expect( str ).to eq "invoked \"continue\" outside of a loop"
  end

end

