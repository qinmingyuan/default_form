$:.push File.expand_path('lib', __dir__)
require 'default_form/version'

Gem::Specification.new do |s|
  s.name = 'default_form'
  s.version = DefaultForm::VERSION
  s.authors = ['qinmingyuan']
  s.email = ['mingyuan0715@foxmail.com']
  s.homepage = 'http://github.com/qinmingyuan/default_form'
  s.summary = 'Rails form builder with default UI'
  s.description = 'Rails form builder that makes it easy to style forms'
  s.license = 'MIT'

  s.files = Dir[
    '{lib}/**/*',
    'LICENSE',
    'README.md',
    'README.zh.md'
  ]
  s.test_files = Dir[
    'test/**/*'
  ]

  s.add_dependency 'rails_com', '~> 1.2'
end
