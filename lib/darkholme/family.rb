module Darkholme
  # Used by systems and engines to get related entities for processing
  class Family
    @next_index = 0
    @families = {}

    class << self
      attr_accessor :next_index
    end

    attr_reader :index, :bits

    # Get a family for matching entities with a specific
    # list of components present
    #
    # @param component_classes [Array<Class>] List of Component classes to
    #   check for
    #
    # @return [Family] The Family instance for that list of Components
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

    # Check if an Entity has all the required Components for the Family
    #
    # @param entity [Entity] The entity to check for membership
    #
    # @return [Boolean] Whether or not the entity is a member of the Family
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

