module Darkholme
  class Bitset
    attr_reader :bits, :set_indexes

    def initialize(*initial_bits)
      @bits = initial_bits.map {|bit| convert_bit(bit) }.inject(:+) || 0

      @set_indexes = []
      @set_indexes += initial_bits.uniq if initial_bits
    end

    def set(bit, value = true)
      if value
        @bits = union convert_bit(bit)
        @set_indexes << bit unless @set_indexes.include?(bit)
      elsif set?(bit)
        @bits = xor convert_bit(bit)
        @set_indexes.delete(bit)
      end

      @bits
    end

    def clear(bit)
      set(bit, false) 
    end

    def set?(bit)
      bit = convert_bit(bit) 
      intersect(bit) == bit
    end

    def include?(other)
      set_indexes & other.set_indexes == other.set_indexes
    end

    def intersect(other)
      @bits & bits_from_object(other) 
    end
    alias_method :&, :intersect

    def intersect?(other)
      if other_bits = bits_from_object(other) > 0
        intersect(other_bits) == other_bits
      else
        false
      end
    end

    def not
      ~@bits
    end
    alias_method :~, :not

    def xor(other)
      @bits ^ bits_from_object(other) 
    end
    alias_method :^, :xor

    def union(other)
      @bits | bits_from_object(other)
    end
    alias_method :|, :union

    def to_s
      @bits.to_s(2)  
    end

    def to_i
      @bits.to_i
    end

    def to_f
      @bits.to_f
    end

    def [](index)
      set?(index)
    end

    def []=(index, value)
      set(index, value)
    end

    def ==(other)
      @bits == other.bits
    end

    private

    def flip(bit)
    end

    def convert_bit(bit)
      2 ** bit
    end

    def bits_from_object(object)
      object.respond_to?(:bits) ? object.bits : object.to_i
    end
  end
end
