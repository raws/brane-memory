$:.unshift File.join(File.dirname(__FILE__), '../lib')
require 'benchmark'
require 'brane'
require 'get_process_mem'

if ARGV.empty?
  $stderr.puts 'usage: benchmark.rb path/to/sentences.txt'
  $stderr.puts 'requires: https://rubygems.org/gems/get_process_mem'
  exit 1
end

@brane = Brane::Memory.new
@sentences_io = File.open(File.expand_path(ARGV.first))
@sentence_count = 0

def load_and_profile_batch(batch_size = 1000)
  sentences_this_batch = 0

  while sentences_this_batch < batch_size && sentence = @sentences_io.gets do
    sentences_this_batch += 1
    @brane.add sentence
  end

  @sentence_count += sentences_this_batch
  puts "batch=#{sentences_this_batch} sentences=#{@sentence_count} rss=#{GetProcessMem.new.mb}mb"
end

Benchmark.bm do |bm|
  until @sentences_io.eof?
    bm.report { load_and_profile_batch }
  end
end

@sentences_io.close
