module Darkholme
  class Family 
    @next_index = 0
    @families = {}

    class << self
      attr_accessor :next_index
    end

    attr_reader :index, :bits

    def self.for(*component_classes)
      bits = Bitset.new
      component_classes.each do |klass|
        bits.set Component.bit_for(klass)
      end

      hash = bits.to_i
      @families[hash] ||= begin
        new bits
      end
    end

    def member?(entity)
      entity.component_bits.include?(bits)
    end

    private

    def initialize(bits)
      @index = self.class.next_index += 1
      @bits = bits
    end
  end
end

