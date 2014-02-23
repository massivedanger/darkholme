module Darkholme
  class IteratingSystem < System
    def update(delta)
      before_processing
      entities.each do |entity|
        process(entity, delta)
      end
      after_processing
    end

    def process(entity, delta)
      raise NotImplementedError.new("You must override #process(entity, delta)")
    end

    def before_processing
    end

    def after_processing
    end
  end
end
