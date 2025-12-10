require "./cpu"

BRK = Instruction.new OpCode::BRK
INX = Instruction.new OpCode::INX
INY = Instruction.new OpCode::INY
PHA = Instruction.new OpCode::PHA
PHP = Instruction.new OpCode::PHP
PLA = Instruction.new OpCode::PLA
PLP = Instruction.new OpCode::PLP

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
  PHA,
  small_op(OpCode::LDA_IMMEDIATE, 42u8),
  PLA,
  BRK
]

cpu = CPU.new
cpu.memory.load_rom 0u16, instructions
cpu.start
cpu.dump_info
