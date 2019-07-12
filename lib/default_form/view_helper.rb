# frozen_string_literal: true

require 'default_form/default_builder'
require 'default_form/search_builder'

module DefaultForm::ViewHelper

  def form_object(record, options ={})
    object_name = options[:as] || record.class.base_class.model_name.param_key
    ActionView::Helpers::FormBuilder.new(object_name, record, self, options)
  end

  def default_form_with(**options, &block)
    options[:builder] ||= DefaultForm::DefaultBuilder
    form_with(options, &block)
  end

  def default_form_object(record = nil, **options)
    object_name = options[:as] || record.class.base_class.model_name.param_key
    DefaultForm::DefaultBuilder.new(object_name, record, self, options)
  end

  def search_form_with(**options, &block)
    options[:builder] ||= DefaultForm::SearchBuilder
    options[:scope] = '' unless options.key?(:scope)
    options[:url] ||= url_for
    form_with(options, &block)
  end

  def search_form_object(record = nil, **options)
    object_name = options[:as] || ''
    DefaultForm::SearchBuilder.new(object_name, record, self, options)
  end

end

ActionView::Base.include DefaultForm::ViewHelper
