require 'default_form/builder/helper'
require 'default_form/config/default'

class DefaultForm::DefaultBuilder < ActionView::Helpers::FormBuilder
  include DefaultForm::Builder::Helper
  include ActiveSupport::Configurable
  config_accessor :class_on do
    DefaultForm.config.on
  end
  config_accessor :class_css do
    DefaultForm.config.css
  end

  def initialize(object_name, object, template, options)
    @origin_on = class_on.merge(options[:on] || {})
    @origin_css = class_css.merge(options[:css] || {})
    @params = template.params
    
    super
  end

end

