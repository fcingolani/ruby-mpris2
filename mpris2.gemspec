Gem::Specification.new do |s|
  s.name        = 'mpris2'
  s.version     = '0.0.2'
  s.date        = '2011-11-27'
  s.summary     = "Control media players via MPRIS2"
  s.description = "Provides a way to control media players using the D-Bus Media Player Remote Interfacing Specification (MPRIS) version 2."
  s.author      = "Federico Cingolani"
  s.email       = 'mail@fcingolani.com.ar'
  s.files       = Dir["lib/**/*.rb"]
  s.homepage    = 'http://rubygems.org/gems/mpris2'
  s.add_dependency "ruby-dbus"
end
