require "./utility"

class Instruction
  getter opcode : UInt8

  def initialize(@opcode : UInt8)
  end

  def as_memory : Bytes
    return to_slice [@opcode]
  end
end

class SmallOpInstruction < Instruction
  getter opcode : UInt8
  getter operand : UInt8

  def initialize(@opcode : UInt8, @operand : UInt8)
  end

  def as_memory : Bytes
    return to_slice [@opcode.as UInt8, @operand.as UInt8]
  end
end

class BigOpInstruction < Instruction
  getter opcode : UInt8
  getter operand : UInt16

  def initialize(@opcode : UInt8, @operand : UInt16)
  end

  def as_memory : Bytes
    return to_slice [@opcode.as UInt8, @operand.as UInt8]
  end
end
