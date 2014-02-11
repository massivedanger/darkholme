module Darkholme
  class Entity
    include Hookable

    has_wrapping_hooks :init, :add, :remove, :added_to_engine,
      :removed_from_engine

    attr_accessor :engine

    def added_to_engine(engine)
      wrap_with_hook(:added_to_engine) do
        @engine = engine
      end
    end

    def removed_from_engine(engine)
      wrap_with_hook(:removed_from_engine) do
        @engine = nil
      end
    end
  end
end
