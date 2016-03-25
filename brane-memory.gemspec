Gem::Specification.new do |gem|
  gem.name = 'brane-memory'
  gem.version = '0.0.1'
  gem.authors = ['Ross Paffett']
  gem.email = ['ross@rosspaffett.com']
  gem.description = 'Simple in-memory Markov chain generator'
  gem.license = 'MIT'
  gem.summary = gem.description
  gem.homepage = 'https://github.com/raws/brane-memory'

  gem.files = `git ls-files`.split($\)
  gem.test_files = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
end
