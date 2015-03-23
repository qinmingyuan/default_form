$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "default_form/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "default_form"
  s.version     = DefaultForm::VERSION
  s.authors     = ["覃明圆"]
  s.email       = ["mingyuan0715@foxmail.com"]
  s.homepage    = "http://github.com/xinshengyin/default_form"
  s.summary     = "Rails form builder that makes it easy to style forms"
  s.description = ""

  s.files = Dir["{lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]
end
