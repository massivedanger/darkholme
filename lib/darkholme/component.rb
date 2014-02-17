module Darkholme
  class Component
    @next_bit = 0
    @bits = {}

    def self.bit_for(klass)
      unless @bits[klass]
        @bits[klass] = @next_bit
        @next_bit += 1
      end

      @bits[klass]
    end

    def bit
      Component.bit_for(self.class) 
    end
  end
end
