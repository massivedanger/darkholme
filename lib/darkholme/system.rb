module Darkholme
  # Updated every frame by the engine, a System manipulates and uses the
  # data contained within a component
  class System
    class << self
      attr_reader :family

      # Set the family for a System. Call this from the body of the
      # class.
      #
      # @param component_classes [Array<Class>] List of component classes the system is
      #
      # @example Standard usage
      #   class MySystem < Darkholme::System
      #     has_family MyComponent, AnotherComponent, LastComponent
      #   end
      #
      # @return [Family] The family for the classes
      def has_family(*component_classes)
        @family = Family.for(*component_classes)
      end
    end

    # @!attribute engine [Engine] The engine this system belongs to
    attr_accessor :engine

    # Called once per frame by the engine. This must be overriden
    # by the subclass.
    #
    # @param delta [Float] Difference in time between the last frame and this one
    def update(delta)
      raise NotImplementedError.new("You must override #update(delta)")
    end

    # Callback called after the system has been added to an Engine
    #
    # @param engine [Engine] The engine the system was added to
    def added_to_engine(engine)
      self.engine = engine
    end

    # Callback called after the system has been removed from an Engine
    #
    # @param engine [Engine] The engine the system was removed from
    def removed_from_engine(engine)
      self.engine = nil if self.engine == engine
    end

    # An Array of all the entities this system is interested in
    #
    # @return [Array<Entity>] All the entities with matching components
    def entities
      engine.entities_for_family(family)
    end

    # Get the system's Family instance
    #
    # @return [Family] The system's family, as defined by #has_family
    def family
      self.class.family
    end
  end
end
