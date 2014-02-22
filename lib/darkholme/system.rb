module Darkholme
  class System
    include Hookable

    has_wrapping_hooks :init, :update, :added_to_engine, 
      :removed_from_engine

    class << self
      attr_reader :family

      def has_family(*component_classes)
        @family = Family.for(*component_classes) 
      end
    end

    attr_accessor :engine

    def initialize
    end

    def update(delta)
      raise "You must override #update(delta)"
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
