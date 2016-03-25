$:.unshift File.join(File.dirname(__FILE__), '../lib')
require 'benchmark'
require 'brane'
require 'get_process_mem'

if ARGV.empty?
  $stderr.puts 'usage: benchmark_sentences.rb path/to/sentences.txt'
  $stderr.puts 'requires: https://rubygems.org/gems/get_process_mem'
  exit 1
end

brane = Brane::Memory.new
sentences_path = File.expand_path(ARGV.first)
sentences_count = 0

File.open(sentences_path) do |io|
  io.each_line do |sentence|
    brane.add sentence
    sentences_count += 1
  end
end

puts Benchmark.measure { 100.times { puts brane.sentence } }
puts "sentences=#{sentences_count} nodes=#{brane.nodes.size} rss=#{GetProcessMem.new.mb}mb"
