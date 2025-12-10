require "./cpu"

cpu = execute_instructions [
  small_op(OpCode::LDA_IMMEDIATE, 69u8),
  PHA,
  small_op(OpCode::LDA_IMMEDIATE, 42u8),
  PLA,
  BRK
]

cpu.dump_info
