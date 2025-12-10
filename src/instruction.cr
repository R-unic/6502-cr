require "./utility"

class Instruction
  getter opcode : OpCode

  def initialize(@opcode : OpCode)
  end

  def as_memory : Bytes
    to_slice [@opcode.value]
  end
end

class SmallOpInstruction < Instruction
  getter operand : UInt8

  def initialize(@opcode : OpCode, @operand : UInt8)
  end

  def as_memory : Bytes
    to_slice [@opcode.value, @operand.as UInt8]
  end
end

class BigOpInstruction < Instruction
  getter operand : UInt16

  def initialize(@opcode : OpCode, @operand : UInt16)
  end

  def as_memory : Bytes
    high, low = high_low(@operand)
    to_slice [@opcode.value, high, low]
  end
end
