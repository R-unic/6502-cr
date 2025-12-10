require "./cpu"

BRK = Instruction.new 0x00

cpu = CPU.new
cpu.memory.load_instruction 0, BRK
cpu.start
cpu.dump_info
