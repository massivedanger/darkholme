module Darkholme
  module Hookable
    module ClassMethods
      # Generates hooks for before and after an event. Generates :before_NAME
      # and :after_NAME
      #
      # @param names [Array] A list of symbols for event names
      # @example has_wrapping_hooks :init, :add, :remove
      def has_wrapping_hooks(*names)
        wrapped_names = names.flat_map do |name|
          ["before_#{name}".to_sym, "after_#{name}".to_sym]
        end

        define_hooks *wrapped_names
      end 
    end

    module InstanceMethods
      def wrap_with_hook(name)
        run_hook "before_#{name}".to_sym
        yield
        run_hook "after_#{name}".to_sym
      end
    end

    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, Hooks
      receiver.send :include, Hooks::InstanceHooks
      receiver.send :include, InstanceMethods
    end
  end
end
