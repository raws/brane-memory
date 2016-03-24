module Brane
  class Node
    EMPTY_PUNCTUATION = [''.freeze]
    WORD_AND_PUNCTUATION_PATTERN = /\A(?<word>.*?)(?<punctuation>[!?\.,…]+)?\z/

    attr_reader :word

    def initialize(normalized_word)
      @word = normalized_word.freeze
      @roots = 0
      @terminations = 0
    end

    def followers
      @followers ||= WeightedSet.new
    end

    def inspect
      "#<Brane::Node:#{object_id} #{word.inspect}>"
    end

    def leaders
      @leaders ||= WeightedSet.new
    end

    def punctuation
      @punctuation ||= WeightedSet.new
    end

    def self.raw_word_to_normalized_word_and_punctuation(raw_word)
      raw_word, punctuation = *raw_word.match(WORD_AND_PUNCTUATION_PATTERN)[1..2]
      normalized_word = raw_word.strip.downcase
      punctuation = punctuation ? punctuation.chars : EMPTY_PUNCTUATION

      [raw_word, normalized_word.freeze, punctuation]
    end

    def root!
      @roots += 1
    end

    def root?
      @roots.positive?
    end

    def termination!
      @terminations += 1
    end

    def terminator?
      @terminations.positive?
    end

    def variants
      @variants ||= WeightedSet.new
    end
  end
end
