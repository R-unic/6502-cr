def to_slice(arr : Array(U)) : Slice(U) forall U
  Slice.new(arr.size) {|i| arr[i]}
end

def high_low(n : UInt16) : Tuple(UInt8, UInt8)
  return {(n >> 8).to_u8, (n & 0xFF).to_u8}
end

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

def instruction_list(instructions : Array(Instruction)) : Bytes
  flattened = [] of UInt8
  instructions.each do |i|
    i.as_memory.each do |byte|
      flattened << byte
    end
  end

  to_slice(flattened)
end

def execute_instructions(instructions : Array(Instruction)) : CPU
  instruction_bytes = instruction_list(instructions)
  cpu = CPU.new
  cpu.memory.load_rom 0u16, instruction_bytes
  cpu.start
  cpu
end
