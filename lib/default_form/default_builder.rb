require 'default_form/builder/helper'
require 'default_form/config/default'

class DefaultForm::DefaultBuilder < ActionView::Helpers::FormBuilder
  include DefaultForm::Builder::Helper
  include ActiveSupport::Configurable

  def initialize(object_name, object, template, options)
    class_on = DefaultForm.config.on.merge(self.class.config.on || {})
    class_css = DefaultForm.config.css.merge(self.class.config.css || {})
    @origin_on = class_on.merge(options[:on] || {})
    @origin_css = class_css.merge(options[:css] || {})
    @params = template.params

    options[:html] ||= {}
    if options[:html][:class] && options[:html][:class].start_with?('new', 'edit')
      options[:html][:class] = origin_css.form
    end
    
    super
  end

end

