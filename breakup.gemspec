# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'breakup/version'

Gem::Specification.new do |gem|
  # Gem Information
  gem.name = 'breakup'
  gem.version = Breakup::VERSION
  gem.authors = ['Ben Scott']
  gem.email = ['ben@reload.me.uk']
  gem.description = 'Build multiple stylesheets based off globally defined breakpoints'
  gem.summary = 'Breakup is a Sass component that allows you to create multiple
  CSS files from a single Sass partial by wrapping your code within breakpoint
  blocks. It allows you to abstract what your Sass partials folder looks like
  from what CSS files you create. Because of this you can easily create per-
  breakpoint CSS files (e.g. base, mobile, tablet and desktop) and fallback
  files where no styles are wrapped (e.g. for oldIE which does not support media
  queries).'
  gem.homepage = 'http://github.com/bpscott/breakup'

  # Gem Files
  gem.files = `git ls-files`.split($/)

  # Dependencies
  gem.add_dependency 'sass',    '>=3.2.0'
  gem.add_dependency 'compass', '>= 0.12.2'
end
