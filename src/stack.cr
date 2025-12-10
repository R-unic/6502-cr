STACK_BOTTOM = 0x0100u16

class Stack
  getter sp : UInt8 = 0xFF

  def initialize(@memory : MemoryBus)
  end

  def size : UInt8
    return 0xFFu8 - @sp
  end

  def pop_byte : UInt8
    byte = top_byte
    @memory.free_byte top_address
    @sp &+= 1
    byte
  end

  def top_byte : UInt8
    @memory.read_byte(top_address + 1)
  end

  def pop_word : UInt16
    word = top_word
    @memory.free_byte top_address + 2
    @memory.free_byte top_address + 1
    @sp &+= 2
    word
  end

  def top_word : UInt16
    high = @memory.read_byte(top_address + 2)
    low = top_byte
    (high.to_u16 << 8) | low.to_u16
  end

  def top_address
    STACK_BOTTOM | @sp
  end

  def push_byte(value : UInt8) : Nil
    address = top_address
    @memory.write_byte address, value
    @sp &-= 1
  end

  def push_word(value : UInt16) : Nil
    high, low = high_low value
    push_byte high  # high byte first
    push_byte low
  end
end
