require "./spec_helper"

describe CPU do
  describe "#brk" do
    it "should set the special halt flag in memory" do
      cpu = execute_instructions [BRK]
      cpu.is_halted?.should be_true
    end
  end
  describe "#lda_immediate" do
    it "should load an immediate value into A" do
      cpu = execute_instructions [small_op(OpCode::LDA_IMMEDIATE, 69u8), BRK]
      cpu.a.should eq 69
    end
  end
  describe "#ldx_immediate" do
    it "should load an immediate value into X" do
      cpu = execute_instructions [small_op(OpCode::LDX_IMMEDIATE, 69u8), BRK]
      cpu.x.should eq 69
    end
  end
  describe "#ldy_immediate" do
    it "should load an immediate value into Y" do
      cpu = execute_instructions [small_op(OpCode::LDY_IMMEDIATE, 69u8), BRK]
      cpu.y.should eq 69
    end
  end
end
