module Darkholme
  class Bitset
    attr_reader :bits

    def initialize(*initial_bits)
      @bits = initial_bits.map {|bit| convert_bit(bit) }.inject(:+) || 0
    end

    def add(bit)
      @bits = @bits | convert_bit(bit) 
    end

    def remove(bit)
      @bits = @bits ^ convert_bit(bit) 
    end

    def contains?(bit)
      bit = convert_bit(bit) 
      @bits & bit == bit
    end

    def to_s
      @bits.to_s(2)  
    end

    private
    def convert_bit(bit)
      2 ** bit
    end
  end
end
