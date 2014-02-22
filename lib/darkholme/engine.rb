module Darkholme
  class Engine
    attr_reader :systems, :entities

    def initialize
      @systems = {}
      @families = {}
      @entities = Set.new
    end

    def add_entity(entity)
      @entities << entity
      entity.added_to_engine self
    end

    def remove_entity(entity)
      @entities.delete entity
      entity.removed_from_engine self
    end

    def add_system(system)
      @systems[system.class] = system
      system.added_to_engine self
    end

    def remove_system(systemClass)
      system = @systems.delete systemClass 
      system.removed_from_engine(self) if system
    end

    def system(systemClass)
      @systems[systemClass]
    end

    def entities_for_family(family)
      @families[family.index] ||= begin
        Set.new.tap do |entities|
          @entities.each do |entity|
            entities << entity if family.member?(entity)
          end
        end
      end
    end

    def update(delta)
      @systems.each {|klass, system| system.update(delta) }
    end

  end
end
