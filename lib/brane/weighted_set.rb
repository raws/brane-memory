require 'set'

module Brane
  class WeightedSet
    attr_reader :set

    def initialize
      @set = SortedSet.new
    end

    def add(object)
      find_or_create_and_add(object).tap do |weighted_set_member|
        weighted_set_member.weight += 1
      end
    end
    alias_method :<<, :add

    def sample
      # TODO Select random member based on weights
      # Weibull distribution might be reasonable compromise: http://stackoverflow.com/a/3110808
      @set.to_a.sample
    end

    private

    def create_and_add(object)
      WeightedSetMember.new(object).tap do |weighted_set_member|
        @set.add weighted_set_member
      end
    end

    def find(object)
      @set.find { |member| member.object == object }
    end

    def find_or_create_and_add(object)
      find(object) || create_and_add(object)
    end
  end
end
