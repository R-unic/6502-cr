require "./spec_helper"

describe MemoryBus do
  memory = MemoryBus.new
  rom_memory = MemoryBus.new

  describe "#write_byte" do
    it "should write the memory and insert a byte" do
      memory.used.should eq 0
      memory.write_byte 0, 69u8
      memory.used.should eq 1
    end
  end
  describe "#read_byte" do
    it "should index the memory and read a byte" do
      value = memory.read_byte 0
      value.should eq 69
    end
  end
  describe "#free_byte" do
    it "should clear the used byte" do
      memory.used.should eq 1
      memory.free_byte 0
      memory.used.should eq 0
    end
    it "should set the byte to zero" do
      value = memory.read_byte 0
      value.should eq 0
    end
  end
  describe "#load_rom" do
    it "should load all bytes" do
      data = to_slice [69, 42, 13] of UInt8
      rom_memory.used.should eq 0
      rom_memory.load_rom 0u16, data
      rom_memory.used.should eq 3
    end
    it "should load correct bytes in correct order" do
      rom_memory.read_byte(0).should eq 69
      rom_memory.read_byte(1).should eq 42
      rom_memory.read_byte(2).should eq 13
    end
  end
end
