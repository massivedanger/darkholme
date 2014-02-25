module Darkholme
  # A subclass of System, IteratingSystem automatically loops through entities
  # belonging to it and calls #process on them, along with a before and after
  # callback
  class IteratingSystem < System
    # Called by the engine, this calls #before_processing, then #process on
    # each entity, then #after_processing
    #
    # @param delta [Float] The difference in time between the last frame
    #   and this one
    # 
    # @return The result of after_processing
    def update(delta)
      before_processing
      entities.each do |entity|
        process(entity, delta)
      end
      after_processing
    end

    # Called on each entity in the collection. This where the various
    # components' data will be manipulated. This must be overridden by
    # the subclass.
    #
    # @param entity [Entity] The entity being manipulated
    # @param delta [Float] The difference in time between the last frame
    #   and this one
    def process(entity, delta)
      raise NotImplementedError.new("You must override #process(entity, delta)")
    end

    # Called once a frame before the entities are looped over and processed
    def before_processing
    end

    # Called once a frame after the entities are looped over and processed
    def after_processing
    end
  end
end
