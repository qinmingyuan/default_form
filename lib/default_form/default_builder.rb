require 'default_form/builder/helper'
require 'default_form/config/default'

class DefaultForm::DefaultBuilder < ActionView::Helpers::FormBuilder
  include DefaultForm::Builder::Helper

  def initialize(object_name, object, template, options)
    @origin_on = DefaultForm.config.on.merge(options[:on] || {})
    @origin_css = DefaultForm.config.css.merge(options[:css] || {})
    @params = template.params

    options[:html] ||= {}
    if options[:html][:class].start_with? 'new', 'edit'
      options[:html][:class] = origin_css.form
    end
    
    super
  end

end

