module Darkholme
  class Entity
    attr_accessor :engine, :components, :component_bits

    def initialize
      self.components = {}
      self.component_bits = Bitset.new
      self.engine = nil
    end

    def added_to_engine(engine)
      self.engine = engine
    end

    def removed_from_engine(engine)
      self.engine = nil
    end

    def add_component(component)
      self.components[component.class] = component
      self.component_bits.set(component.bit)

      component 
    end

    def remove_component(component_class)
      if removed_component = component_for(component_class)
        self.component_bits.clear(removed_component.bit)
        self.components.delete(component_class)
      end

      removed_component
    end

    def has_component?(component_class)
      self.components.include? component_class
    end

    def component_for(component_class)
      self.components[component_class]
    end
  end
end
