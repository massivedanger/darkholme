module Darkholme
  class System
    class << self
      attr_reader :family

      def has_family(*component_classes)
        @family = Family.for(*component_classes) 
      end
    end

    attr_accessor :engine

    def update(delta)
      raise NotImplementedError.new("You must override #update(delta)")
    end

    def added_to_engine(engine)
      self.engine = engine
    end

    def removed_from_engine(engine)
      self.engine = nil if self.engine == engine
    end

    def entities
      engine.entities_for_family(family)
    end

    def family
      self.class.family
    end
  end
end
