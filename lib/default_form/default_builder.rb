# frozen_string_literal: true

require 'default_form/builder/helper'
require 'default_form/config/default'

class DefaultForm::DefaultBuilder < ActionView::Helpers::FormBuilder
  include DefaultForm::Builder::Helper
  include ActiveSupport::Configurable

  def initialize(object_name, object, template, options)
    @origin_on = DefaultForm.config.on.merge(self.class.config.on || {})
    @origin_css = DefaultForm.config.css.merge(self.class.config.css || {})
    @origin_on.merge!(options[:on] || {})
    @origin_css.merge!(options[:css] || {})
    @params = template.params

    if options[:class] && options[:class].start_with?('new', 'edit')
      options[:class] = origin_css.form
    end
    options[:class] = origin_css.form unless options.key?(:class)

    super
  end

end

