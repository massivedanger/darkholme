module Darkholme
  class Component
    @next_bit = -1 # So the first bit is 0
    @bits = {}

    def self.bit_for(klass)
      @bits[klass] ||= @next_bit += 1
    end

    def bit
      Component.bit_for(self.class) 
    end
  end
end
