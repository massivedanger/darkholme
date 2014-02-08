module Darkholme
  class Engine
    include Hookable

    has_wrapping_hooks :init, :add, :remove, 
      :add_system, :remove_system, :get_system
  end
end
