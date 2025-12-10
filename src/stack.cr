STACK_BOTTOM = 0x0100u16

class Stack
  getter sp = 0xFFu8

  def initialize(@memory : MemoryBus)
  end

  def pop_byte : UInt8
    @sp &+= 1
    top_byte
  end

  def top_byte : UInt8
    @memory.read top_address
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
