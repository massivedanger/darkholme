module Darkholme
  class System
    include Hookable

    has_wrapping_hooks :init, :update, :added_to_engine, 
      :removed_from_engine
    
    attr_reader :family

    def initialize
      @entities = []
    end

    def update(delta)
      raise "You must override #update(delta)"
    end

    def added_to_engine(engine)
      @engine = engine
    end

    def removed_from_engine(engine)
      @engine = nil if @engine == engine
    end
  end
end
