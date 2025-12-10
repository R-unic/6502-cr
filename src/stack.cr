STACK_BOTTOM = 0x0100u16

class Stack
  getter sp = 0xFFu8

  def initialize(@memory : MemoryBus)
  end

  def pop_byte : UInt8
    @sp &+= 1
    top_byte
  end

  def pop_word : UInt8
    @sp &+= 2
    top_word
  end

  def top_byte : UInt8
    @memory.read top_address
  end

  def top_word : UInt16
    low = top_byte
    high = @memory.read top_address - 1
    (high.to_u16 << 8) || low.to_u16
  end

  def top_address
    STACK_BOTTOM | @sp
  end

  def push_byte(value : UInt8) : Nil
    address = top_address
    @memory.write address, value
    @sp &-= 1
  end

  def push_word(value : UInt16) : Nil
    high, low = high_low value
    push_byte high  # high byte first
    push_byte low
  end
end
