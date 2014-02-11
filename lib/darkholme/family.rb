module Darkholme
  class Family
    @families = {}
    @index = 0

    attr_reader :index

    class << self
      def for(*componentClasses)
        
      end
    end

    def initialize
      @@index += 1

      @index = @@index.dup
    end

    def matches?(entity)
      
    end
  end
end
