require 'default_form/builder/helper'

class DefaultForm::DefaultBuilder < ActionView::Helpers::FormBuilder
  delegate :content_tag, to: :@template
  include DefaultForm::Builder::Helper

  def initialize(object_name, object, template, options)
    options[:html] ||= {}
    options[:html][:class] ||= DefaultForm.config.css.form
    @origin_on = DefaultForm.config.on.merge(options[:on] || {})
    @origin_css = DefaultForm.config.css.merge(options[:css] || {})
    super
  end

end

