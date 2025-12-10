OPCODES = Array(Proc(CPU, Nil)).new 2 ** 8 { ->(cpu : CPU) { cpu.raise "unimplemented" } }

macro define_op(list)
  {% for name, index in list %}
    OPCODES[OpCode::{{ name.id.upcase }}.value] = ->(cpu : CPU) { cpu.{{ name }} }
  {% end %}
end

enum OpCode : UInt8
  BRK = 0x00
  PHP = 0x08
  PHA = 0x48
  JMP_ABSOLUTE = 0x4C
  LDY_IMMEDIATE = 0xA0
  LDX_IMMEDIATE = 0xA2
  LDA_IMMEDIATE = 0xA9
  INY = 0xC8
  INX = 0xE8
  NOP = 0xEA
end

define_op [brk, lda_immediate, ldx_immediate, ldy_immediate, inx, iny, jmp_absolute, nop, pha, php]
