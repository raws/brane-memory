module Brane
  class WeightedSetMember
    attr_reader :object
    attr_accessor :weight

    def initialize(object)
      @object = object
      @weight = 0
    end

    def ==(other)
      object == other.object
    end

    def <=>(other)
      weight <=> other.weight
    end
  end
end
