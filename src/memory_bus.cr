require "./instruction"

class MemoryBus
  getter ram = Bytes.new 2 ** 16

  def read(address : UInt16) : UInt8
    return @ram[address]
  end

  def write(address : UInt16, value : UInt8) : Nil
    @ram[address] = value
  end

  def load_instruction(address : UInt16, instruction : Instruction) : Nil
    load_rom(address, instruction.as_memory)
  end

  def load_rom(address : UInt16, data : Bytes) : Nil
    data.each_with_index do |b, i|
      write(address + i, b)
    end
  end

  def size : Int32
    return @ram.size
  end
end
