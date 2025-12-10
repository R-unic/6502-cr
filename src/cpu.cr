require "./ops"
require "./cycles"
require "./memory_bus"

HALT_ADDRESS = 0xFFFFu16
HALT_FLAG = 0xFBu8

enum Flag : UInt8
  C = 0x01u8
  Z = 0x02u8
  I = 0x04u8
  D = 0x08u8
  B = 0x10u8
  U = 0x20u8  # unused, always 1 in pushes
  V = 0x40u8
  N = 0x80u8
end

class CPU
  getter a = 0u8
  getter x = 0u8
  getter y = 0u8
  getter pc = 0u16
  getter sp = 0xffu8
  getter p = 0x20u8 # bit 5 is always set
  getter memory = MemoryBus.new
  getter cycles = 0u8;

  def start : Nil
    until is_halted
      step
    end
  end

  def dump_info : Nil
    puts "\nRegisters:"
    puts "A: #{@a.to_s(16)}"
    puts "X: #{@x.to_s(16)}"
    puts "Y: #{@y.to_s(16)}"
    puts "PC: #{@pc.to_s(16)}"
    puts "SP: #{@sp.to_s(16)}"

    puts "\nFlags:"
    puts "N (negative): #{get_flag(Flag::N).to_s}"
    puts "V (overflow): #{get_flag(Flag::V).to_s}"
    puts "B (break): #{get_flag(Flag::B).to_s}"
    puts "D (decimal mode): #{get_flag(Flag::D).to_s}"
    puts "I (interrupt disable): #{get_flag(Flag::I).to_s}"
    puts "Z (zero): #{get_flag(Flag::Z).to_s}"
    puts "C (carry): #{get_flag(Flag::C).to_s}"
  end

  def raise(message : String) : Nil
    puts message
    halt
  end

  def lda_immediate : Nil
    @a = fetch_immediate
    set_flag(Flag::Z, @a.zero?)
    set_flag(Flag::N, (@a & 0x80) != 0)
  end

  def brk : Nil
    @pc &+= 1
    push_word(@pc)
    status = @p | Flag::B.value | Flag::U.value
    push_byte(status)
    set_flag(Flag::I, true)

    low = @memory.read(0xFFFE).to_u16
    high = @memory.read(0xFFFF).to_u16
    @pc = (high << 8) | low
    halt
  end

  private def is_halted : Bool
    return @memory.read(HALT_ADDRESS) == HALT_FLAG
  end

  private def halt : Nil
    @memory.write HALT_ADDRESS, HALT_FLAG
  end

  private def step : Nil
    return deduct_cycles 1 unless @cycles.zero?

    opcode = @memory.read(@pc)
    @pc &+= 1
    execute = OPCODES[opcode]?

    return raise "Unknown opcode: #{OpCode[opcode]}" if execute.nil?

    puts "Executing opcode: #{OpCode[opcode]}"
    @cycles = CYCLES[opcode]
    execute.call(self)
  end

  private def fetch_immediate : UInt8
    value = @memory.read(@pc)
    @pc &+= 1
    value
  end

  private def push_byte(value : UInt8) : Nil
    addr = 0x0100u16 | @sp
    @memory.write(addr, value)
    @sp &-= 1
  end

  private def push_word(value : UInt16) : Nil
    push_byte((value >> 8).to_u8)  # high byte first
    push_byte((value & 0xFF).to_u8)
  end

  private def set_flag(mask : Flag, state : Bool) : Nil
    if state
      @p |= mask.value
    else
      @p &= ~mask.value
    end
  end

  private def get_flag(mask : Flag) : UInt8
    (@p & mask.value) == 0 ? 0u8 : 1u8
  end

  private def deduct_cycles(count : Int32) : Nil
    @cycles &-= count
  end
end
