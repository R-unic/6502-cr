OPCODES = Array(Proc(CPU, Nil)).new 2 ** 8 { ->(cpu : CPU) { cpu.raise "unimplemented" } }

macro define_op(hash)
  {% for op, name in hash %}
    OPCODES[{{ op }}] = ->(cpu : CPU) { cpu.{{ name }} }
  {% end %}
end

define_op({
  0x00 => brk
})
