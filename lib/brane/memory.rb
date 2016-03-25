module Brane
  class Memory
    WORD_SPLIT_PATTERN = /\s+/

    attr_reader :nodes

    def initialize
      @mutex = Mutex.new
      @nodes = {}
      @roots = WeightedSet.new
      @terminators = WeightedSet.new
    end

    def add(sentence)
      return if sentence =~ /\A\s*\z/

      words = sentence.split(WORD_SPLIT_PATTERN).map(&:freeze)

      @mutex.synchronize do
        nodes = words.map { |raw_word| find_or_create_node(raw_word) }

        nodes.each_cons(3) do |leader, current, follower|
          current.leaders << leader
          current.followers << follower
        end

        root = nodes.first
        root.root!
        root.followers << nodes[1]
        @roots << root

        terminator = nodes.last
        terminator.termination!
        terminator.leaders << nodes[-2]
        @terminators << terminator

        nil
      end
    end

    def sentence(seed: nil)
      @mutex.synchronize do
        # TODO
      end
    end

    private

    def create_and_add_node(normalized_word)
      Node.new(normalized_word).tap do |node|
        @nodes[normalized_word] = node
      end
    end

    def find_node(normalized_word)
      @nodes[normalized_word]
    end

    def find_or_create_node(raw_word)
      raw_word_without_punctuation, normalized_word, punctuation =
        *Node.raw_word_to_normalized_word_and_punctuation(raw_word)

      node = find_node(normalized_word) || create_and_add_node(normalized_word)
      node.variants << raw_word_without_punctuation
      punctuation.each { |char| node.punctuation << char }

      node
    end
  end
end
