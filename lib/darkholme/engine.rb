module Darkholme
  class Engine
    include Hookable

    has_wrapping_hooks :init, :add_entity, :remove_entity, 
      :add_system, :remove_system, :system, :entities_for_family,
      :update

    attr_reader :systems, :entities

    def initialize
      wrap_with_hook(:init) do
        @systems = {}
        @families = {}
        @entities = Set.new
      end
    end

    def add_entity(entity)
      wrap_with_hook(:add_entity) do
        @entities << entity
        entity.added_to_engine self
      end
    end

    def remove_entity(entity)
      wrap_with_hook(:remove_entity) do
        @entities.delete entity
        entity.removed_from_engine self
      end
    end

    def add_system(system)
      wrap_with_hook(:add_system) do
        @systems[system.class] = system
        system.added_to_engine self
      end
    end

    def system(systemClass)
      wrap_with_hook(:get_system) do
        @systems[systemClass]
      end
    end

    def entities_for_family(family)
      wrap_with_hook(:entities_for_family) do
        @families[family] ||= begin
          [].tap do |entities|
            @entities.each do |entity|
              entities.add(entity) if family.matches?(entity)
            end
          end
        end
      end
    end

    def update(delta)
      wrap_with_hook(:update) do
        @systems.each {|klass, system| system.update(delta) }
      end
    end

  end
end
