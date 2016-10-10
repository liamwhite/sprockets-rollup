$:.unshift File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name    = 'sprockets-rollup'
  s.version = '0.3.0'

  s.summary     = "Sprockets Rollup"
  s.description = <<-EOS
    A Sprockets transformer that converts ES6 imports into bundles
  EOS
  s.license = "MIT"

  s.files = [
    'lib/sprockets/rollup.rb',
    'lib/sprockets/rollup.js',
    'LICENSE'
  ]

  s.add_dependency 'sprockets', '>= 3.0.0'

  s.authors = ['Liam P. White']
  s.email   = 'foo@example.com'
end
