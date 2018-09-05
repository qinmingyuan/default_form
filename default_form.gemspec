$:.push File.expand_path('../lib', __FILE__)
require 'default_form/version'

Gem::Specification.new do |s|
  s.name = 'default_form'
  s.version = DefaultForm::VERSION
  s.authors = ['qinmingyuan']
  s.email = ['mingyuan0715@foxmail.com']
  s.homepage = 'http://github.com/qinmingyuan/default_form'
  s.summary = 'Rails form builder that makes it easy to style forms'
  s.description = ''

  s.files = Dir[
    '{lib}/**/*',
    'README.md',
    'README.zh.md'
  ]
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '>= 5.2'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'factory_bot_rails'
end
