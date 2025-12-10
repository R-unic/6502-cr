require "./cpu"

BRK = Instruction.new OpCode::BRK
INX = Instruction.new OpCode::INX
INY = Instruction.new OpCode::INY

def small_op(op : OpCode, data : UInt8) : Instruction
  return SmallOpInstruction.new op, data
end

def instruction_list(instructions : Array(Instruction))
  flattened = [] of UInt8
  instructions.each do |i|
    i.as_memory.each do |byte|
      flattened << byte
    end
  end

  to_slice(flattened)
end

instructions = instruction_list [
  small_op(OpCode::LDA_IMMEDIATE, 69u8),
  small_op(OpCode::LDX_IMMEDIATE, 41u8),
  small_op(OpCode::LDY_IMMEDIATE, 12u8),
  small_op(OpCode::JMP_ABSOLUTE, 6u8),
  INY,
  INX,
  BRK
]

cpu = CPU.new
cpu.memory.load_rom 0u16, instructions
cpu.start
cpu.dump_info
