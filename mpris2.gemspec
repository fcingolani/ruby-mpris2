Gem::Specification.new do |s|
  s.name        = 'mpris2'
  s.version     = '0.0.1'
  s.date        = '2011-04-28'
  s.summary     = "MPRIS2"
  s.description = "An MPRIS2 gem"
  s.author      = "Federico Cingolani"
  s.email       = 'mail@fcingolani.com.ar'
  s.files       = Dir["lib/**/*.rb"]
  s.homepage    = 'http://rubygems.org/gems/mpris2'
  s.add_dependency "ruby-dbus"
end
