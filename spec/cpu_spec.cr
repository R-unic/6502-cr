require "./spec_helper"

describe CPU do
  it "BRK" do
    cpu = execute_instructions [BRK]
    cpu.is_halted?.should be_true
  end
  it "LDA (immediate)" do
    cpu = execute_instructions [small_op(OpCode::LDA_IMMEDIATE, 69u8), BRK]
    cpu.a.should eq 69
  end
  it "LDX (immediate)" do
    cpu = execute_instructions [small_op(OpCode::LDX_IMMEDIATE, 69u8), BRK]
    cpu.x.should eq 69
  end
  it "LDY (immediate)" do
    cpu = execute_instructions [small_op(OpCode::LDY_IMMEDIATE, 69u8), BRK]
    cpu.y.should eq 69
  end
end
