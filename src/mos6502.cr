require "./cpu"

BRK = Instruction.new 0x00

def lda_immediate(data : UInt8) : Instruction
  return SmallOpInstruction.new 0xA9, data
end

instructions = to_slice([
  *lda_immediate(69u8).as_memory,
  *BRK.as_memory
] of UInt8)

cpu = CPU.new
cpu.memory.load_rom(0u16, instructions)
cpu.start
cpu.dump_info
