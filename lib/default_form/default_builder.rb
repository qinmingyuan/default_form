require 'default_form/builder/helper'
require 'default_form/config/default'

class DefaultForm::DefaultBuilder < ActionView::Helpers::FormBuilder
  include DefaultForm::Builder::Helper
  include ActiveSupport::Configurable

  def initialize(object_name, object, template, options)
    return super if options[:default].is_a?(FalseClass)
    class_on = DefaultForm.config.on.merge(self.class.config.on || {})
    class_css = DefaultForm.config.css.merge(self.class.config.css || {})
    @origin_on = class_on.merge(options[:on] || {})
    @origin_css = class_css.merge(options[:css] || {})
    @params = template.params

    options[:skip_default_ids] = origin_on.skip_default_ids
    if options[:class] && options[:class].start_with?('new', 'edit')
      options[:class] = origin_css.form
    end
    options[:class] ||= origin_css.form

    super
  end

end

