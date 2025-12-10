def to_slice(arr : Array(U)) : Slice(U) forall U
  Slice.new(arr.size) {|i| arr[i]}
end
