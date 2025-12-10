def to_slice(arr : Array(U)) : Slice(U) forall U
  Slice.new(arr.size) {|i| arr[i]}
end

def high_low(n : UInt16) : Tuple(UInt8, UInt8)
  return {(n >> 8).to_u8, (n & 0xFF).to_u8}
end
