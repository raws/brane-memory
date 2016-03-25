Brane is a simple Ruby [Markov chain](http://en.wikipedia.org/wiki/Markov_chain) generator. This gem stores its data in memory.

### Usage

Instantiate a `Brane::Memory` and add sentences to it. Use `#sentence` to generate a random sentence.

```ruby
require 'brane'

brane = Brane::Memory.new

File.open('chatter.txt') do |f|
  f.each_line do |sentence|
    brane.add sentence
  end
end

puts brane.sentence #=> "I usually mix baileys WITH millenials"
```

### License (MIT)

Copyright (c) 2016 Ross Paffett

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
