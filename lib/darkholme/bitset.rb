module Darkholme
  # A class for easier bitset management with handy bitwise methods
  class Bitset
    attr_reader :bits
    attr_reader :set_indexes

    # Create a new Bitset with optional initial bits
    #
    # @param *initial_bits [Array<Fixnum>] The initial bit indexes to set
    #
    # @example Setting multiple bits initially
    #   Bitset.new 1, 2, 10, 30
    #
    # @return [Bitset] The new bitset
    def initialize(*initial_bits)
      @bits = initial_bits.map {|bit| convert_bit(bit) }.inject(:+) || 0

      @set_indexes = []
      @set_indexes += initial_bits.uniq if initial_bits
    end

    # Set the bit at an index to true or false.
    # Sets the bit to 1, by default
    #
    # @param bit [Fixnum] Index of bitset to set
    # @param value [Boolean] Whether to set the bit to 0 or 1
    #
    # @return [Fixnum] The bitset's integer representation after being modified
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

    # Set a bit at supplied index to 0
    #
    # @param bit [Fixnum] The index of the bit to modify
    #
    # @return [Fixnum] The bitset's integer representation after being modified
    def clear(bit)
      set(bit, false)
    end

    # Checks if a bit at an index is set to 1
    #
    # @param bit [Fixnum] Index of bit to check
    #
    # @return [Boolean] Whether or not the bit is set to one
    def set?(bit)
      bit = convert_bit(bit)
      intersect(bit) == bit
    end

    # Checks if all of another bitset's flipped bits are flipped in this one
    #
    # @param other [Bitset] Bitset use for inclusion check
    #
    # @return [Boolean] Whether or not all bits are flipped in both
    def include?(other)
      set_indexes & other.set_indexes == other.set_indexes
    end

    # Perform a bitwise AND
    #
    # @param other [Bitset or Fixnum] Other object to use for AND
    #
    # @return [Fixnum] Bits after operation
    def intersect(other)
      @bits & bits_from_object(other)
    end
    alias_method :&, :intersect

    # Perform a bitwise NOT on the current bitset
    #
    # @return [Fixnum] Bits after operation
    def not
      ~@bits
    end
    alias_method :~, :not

    # Perform a bitwise XOR
    #
    # @param other [Bitset or Fixnum] Other object to use for XOR
    #
    # @return [Fixnum] Bits after operation
    def xor(other)
      @bits ^ bits_from_object(other)
    end
    alias_method :^, :xor

    # Perform a bitwise OR
    #
    # @param other [Bitset or Fixnum] Other object to use for OR
    #
    # @return [Fixnum] Bits after operation
    def union(other)
      @bits | bits_from_object(other)
    end
    alias_method :|, :union

    # Return the binary representation of the bitset
    #
    # @return [String] Binary of current bits
    def to_s
      @bits.to_s(2)
    end

    # Return Integer representation of the bitset
    #
    # @return [Fixnum] Integer of current bits
    def to_i
      @bits.to_i
    end

    # Return Float representation of the bitset
    #
    # @return [Float] Float of current bits
    def to_f
      @bits.to_f
    end

    # Check for a bit at an index to be set to 1
    #
    # @param index [Fixnum] Index of bit to check
    #
    # @return [Boolean] Whether or not the bit is set to 1
    def [](index)
      set?(index)
    end

    # Set a bit at an index to 0 or 1
    #
    # @param index [Fixnum] Index of bitset to set
    # @param value [Boolean] Whether to set the bit to 0 or 1
    #
    # @return [Fixnum] The bitset's integer representation after being modified
    def []=(index, value)
      set(index, value)
    end

    # Check if other bitset's bits match the current ones
    #
    # @param other [Bitset] Other bitset
    #
    # @return [Boolean] Whether or not the bits match
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
