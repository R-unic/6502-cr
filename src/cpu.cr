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
  getter a : UInt8 = 0u8
  getter x : UInt8 = 0u8
  getter y : UInt8 = 0u8
  getter pc : UInt16 = 0u16
  getter p : UInt8 = 0x20u8 # bit 5 is always set
  getter cycles : UInt8 = 0u8;
  getter memory = MemoryBus.new
  getter stack = Stack.new MemoryBus.new

  def initialize
    @stack = Stack.new @memory
  end

  def start : Nil
    until is_halted?
      step
    end
  end

  def dump_info : Nil
    puts "\nRegisters:"
    puts "A: 0x#{@a.to_s(16)} (#{@a})"
    puts "X: 0x#{@x.to_s(16)} (#{@x})"
    puts "Y: 0x#{@y.to_s(16)} (#{@y})"
    puts "PC: 0x#{@pc.to_s(16)} (#{@pc})"
    puts "SP: 0x#{@stack.sp.to_s(16)} (#{@stack.sp})"
    puts "Memory used: #{@memory.used} bytes"

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

  def brk : Nil
    advance_pc
    @stack.push_word @pc
    php
    set_flag Flag::I, true

    low = @memory.read_byte(0xFFFE).to_u16
    high = @memory.read_byte(0xFFFF).to_u16
    @pc = (high << 8) | low
    halt
  end

  def lda_immediate : Nil
    @a = fetch_immediate
    set_zn @a
  end

  def ldx_immediate : Nil
    @x = fetch_immediate
    set_zn @x
  end

  def ldy_immediate : Nil
    @y = fetch_immediate
    set_zn @y
  end

  def inx : Nil
    @x += 1
    set_zn @x
  end

  def iny : Nil
    @y += 1
    set_zn @y
  end

  def jmp_absolute : Nil
    address = @memory.read_byte(@pc + 1)
    @pc = address.to_u16
  end

  def nop : Nil
  end

  def pha : Nil
    @stack.push_byte @a
  end

  def php : Nil
    @stack.push_byte status_with_break
  end

  def pla : Nil
    @a = @stack.pop_byte
    set_zn @a
  end

  def plp : Nil
    @p = @stack.pop_byte
  end

  def rti : Nil
    plp
    @pc = @stack.pop_word
  end

  def rti : Nil
    @pc = @stack.pop_word + 1
  end

  def is_halted? : Bool
    @memory.read_byte(HALT_ADDRESS) == HALT_FLAG
  end

  private def halt : Nil
    @memory.write_byte HALT_ADDRESS, HALT_FLAG
  end

  private def step : Nil
    return deduct_cycles 1 unless @cycles.zero?

    opcode = fetch_immediate
    execute = OPCODES[opcode]?
    op_name = OpCode[opcode]

    return raise "Unknown opcode: #{op_name}" if execute.nil?

    @cycles = CYCLES[opcode]
    execute.call(self)
  end

  private def status_with_break : UInt8
    @p | Flag::B.value | Flag::U.value
  end

  private def fetch_immediate : UInt8
    value = @memory.read_byte @pc
    advance_pc
    value
  end

  private def set_zn(n : UInt8) : Nil
    set_zero n
    set_negative n
  end

  private def set_zero(n : UInt8) : Nil
    set_flag(Flag::Z, n.zero?)
  end

  private def set_negative(n : UInt8) : Nil
    set_flag(Flag::N, (n & 0x80) != 0)
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

  private def advance_pc(count = 1) : Nil
    @pc &+= count
  end
end
