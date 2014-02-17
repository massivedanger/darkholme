module Darkholme
  class Entity
    include Hookable

    has_wrapping_hooks :init, :add_component, :remove_component, 
      :added_to_engine, :removed_from_engine

    attr_accessor :engine, :components, :component_bits, :family_bits

    def initialize
      wrap_with_hook(:init) do
        self.components = {}
        self.component_bits = Bitset.new
        self.family_bits = Bitset.new
        self.engine = nil
      end
    end

    def added_to_engine(engine)
      wrap_with_hook(:added_to_engine) do
        self.engine = engine
      end
    end

    def removed_from_engine(engine)
      wrap_with_hook(:removed_from_engine) do
        self.engine = nil
      end
    end

    def add_component(component)
      wrap_with_hook(:add_component) do
        self.components[component.class] = component
        self.component_bits.set(component.bit)

        component_for(component.class)
      end
    end

    def remove_component(component_class)
      wrap_with_hook(:remove_component) do
        if removed_component = component(component_class)
          self.component_bits.clear(removed_component.bit)
          self.components.delete(component_class)
        end

        component_for(component_class) 
      end
    end

    def has_component?(component_class)
      component_for(component_class) ? true : false
    end

    def component_for(component_class)
      self.components[component_class]
    end
  end
end
