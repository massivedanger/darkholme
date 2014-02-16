module Darkholme
  class Bitset
    attr_accessor :bits

    def initialize(*initial_bits)
      self.bits = initial_bits.map {|bit| convert_bit(bit) }.inject(:+) || 0
    end

    def set(bit, value = true)
      if value
        self.bits = self.bits | convert_bit(bit) 
      elsif set?(bit)
        flip(bit)
      else
        self.bits
      end
    end

    def clear(bit)
      set(bit, false) 
    end

    def flip(bit)
      self.bits = self.bits ^ convert_bit(bit)
    end

    def set?(bit)
      bit = convert_bit(bit) 
      self.bits & bit == bit
    end

    def to_s
      self.bits.to_s(2)  
    end

    def [](index)
      set?(index)
    end

    def []=(index, value)
      set(index, value)
    end

    def ==(other)
      self.bits == other.bits
    end

    private

    def convert_bit(bit)
      2 ** bit
    end
  end
end
