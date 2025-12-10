OPCODES = Array(Proc(CPU, Nil)).new 2 ** 8 { ->(cpu : CPU) { cpu.raise "unimplemented" } }

macro define_op(list)
  {% for name, index in list %}
    OPCODES[OpCode::{{ name.id.upcase }}.value] = ->(cpu : CPU) { cpu.{{ name }} }
  {% end %}
end

enum OpCode : UInt8
  BRK = 0x00
  LDA_IMMEDIATE = 0xA9
end

define_op [brk, lda_immediate]
