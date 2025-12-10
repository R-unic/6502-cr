require "./spec_helper"

describe Stack do
  stack = Stack.new MemoryBus.new

  describe "#push_byte" do
    it "should push a byte to the stack" do
      stack.push_byte 69
      stack.size.should eq 1
    end
  end
  describe "#top_byte" do
  it "should read the top byte from the stack" do
      stack.size.should eq 1
      value = stack.top_byte
      value.should eq 69
    end
  end
  describe "#pop_byte" do
    it "should remove the top byte from the stack" do
      value = stack.pop_byte
      value.should eq 69
      stack.size.should eq 0
    end
  end
  describe "#push_word" do
    it "should push a word to the stack" do
      stack.push_word 42069
      stack.size.should eq 2
    end
  end
  describe "#top_word" do
  it "should read the top word from the stack" do
      stack.size.should eq 2
      value = stack.top_word
      value.should eq 42069
    end
  end
  describe "#pop_word" do
    it "should remove the top word from the stack" do
      value = stack.pop_word
      value.should eq 42069
      stack.size.should eq 0
    end
  end
end
