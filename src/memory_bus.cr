require "./instruction"
require "./stack"

class MemoryBus
  getter ram = Bytes.new 2 ** 16
  getter used : UInt32 = 0

  def read_byte(address : UInt16) : UInt8
    @ram[address]
  end

  def write_byte(address : UInt16, value : UInt8) : Nil
    @ram[address] = value
    @used &+= 1
  end

  def free_byte(address : UInt16) : Nil
    @ram[address] = 0
    @used &-= 1
  end

  def load_instruction(address : UInt16, instruction : Instruction) : Nil
    load_rom(address, instruction.as_memory)
  end

  def load_rom(address : UInt16, data : Bytes) : Nil
    data.each_with_index do |byte, i|
      write_byte(address + i, byte)
    end
  end
end
