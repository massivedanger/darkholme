module Darkholme
  # An Entity contains Components, which hold data which is manipulated
  # by a System
  class Entity
    attr_accessor :engine, :components, :component_bits, :family_bits

    # Create a new Entity
    #
    # @return [Entity] The new Entity
    def initialize
      self.components = {}
      self.component_bits = Bitset.new
      self.family_bits = Bitset.new
      self.engine = nil
    end

    # Callback called after the entity has been added to an Engine
    #
    # @param engine [Engine] The engine the system was added to
    def added_to_engine(engine)
      self.engine = engine
    end

    # Callback called after the engine has been removed from an Engine
    #
    # @param engine [Engine] The engine the entity was removed from
    def removed_from_engine(engine)
      self.engine = nil
    end

    # Add a component to an entity
    #
    # @param component [Component] The component being added
    #
    # @return [Component] The component that was added
    def add_component(component)
      self.components[component.class] = component
      self.component_bits.set(component.bit)
      self.engine.component_added(self, component) if self.engine

      component
    end

    # Remove a component from an entity
    #
    # @param component_class [Class] The class of the component being removed
    #
    # @return [Component] The component that was removed
    def remove_component(component_class)
      if removed_component = component_for(component_class)
        self.component_bits.clear(removed_component.bit)
        self.components.delete(component_class)
        self.engine.component_removed(self, removed_component) if self.engine
      end

      removed_component
    end

    # Check to see if an entity contains a type of component
    #
    # @param component_class [Class] The class of the component to check for
    #
    # @return [Boolean] Whether or not the entity has the component
    def has_component?(component_class)
      self.components.include? component_class
    end

    # Retrieve a component of a certain class from an entity
    #
    # @param component_class [Class] The class of the component to get
    #
    # @return [Component] The component, if present
    def component_for(component_class)
      self.components[component_class]
    end
  end
end
