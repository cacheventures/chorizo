Gem::Specification.new do |s|
  s.name        = 'chorizo'
  s.version     = '0.1.4'
  s.date        = '2018-02-16'
  s.summary     = 'Parse and set environment variables on hosting providers'
  s.description = 'Parse and set environment variables on hosting providers'
  s.authors     = ["Daniel Arnold"]
  s.email       = 'dan@cacheventures.com'
  s.files       = Dir['lib/*']
  s.add_runtime_dependency 'colorize', '0.7.7'
  s.add_runtime_dependency 'slop', '~> 3.6'
  s.add_runtime_dependency 'hiera-eyaml', '2.1.0'
  s.executables << 'chorizo'
  s.homepage    = 'http://rubygems.org/gems/chorizo'
  s.homepage    = 'https://github.com/cacheventures/chorizo'
  s.license     = 'MIT'
end
