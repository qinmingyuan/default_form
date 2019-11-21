# frozen_string_literal: true

require 'default_form/builder/helper'
require 'default_form/config'

class DefaultForm::SearchBuilder < ActionView::Helpers::FormBuilder
  include DefaultForm::Builder::Helper
  include ActiveSupport::Configurable

  def initialize(object_name, object, template, options)
    @origin_on = DefaultForm.config.on.merge(self.class.config.on || {})
    @origin_css = DefaultForm.config.css.merge(self.class.config.css || {})
    @origin_on.merge!(options[:on] || {})
    @origin_css.merge!(options[:css] || {})
    @params = template.params
    _values = Hash(@params.permit(object_name => {})[object_name])

    object ||= ActiveSupport::InheritableOptions.new(_values.symbolize_keys)

    if object.is_a?(ActiveRecord::Base)
      object.assign_attributes _values.slice(*object.attribute_names)
    end

    options[:skip_default_ids] = origin_on[:skip_default_ids]
    options[:local] ||= true unless options[:remote]
    options[:method] ||= 'get'
    options[:class] = origin_css[:form] unless options.key?(:class)

    super
  end

  def submit_default_value
    I18n.t 'helpers.submit.search'
  end

end

