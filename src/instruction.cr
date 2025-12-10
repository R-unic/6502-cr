private def to_slice(arr : Array(U)) : Slice(U) forall U
  Slice.new(arr.size) {|i| arr[i]}
end

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
    return to_slice [@opcode, @operand]
  end
end

class BigOpInstruction < Instruction
  getter opcode : UInt8
  getter operand : UInt16

  def initialize(@opcode : UInt8, @operand : UInt16)
  end

  def as_memory : Bytes
    return to_slice [@opcode, @operand]
  end
end
