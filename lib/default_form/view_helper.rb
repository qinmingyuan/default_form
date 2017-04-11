require 'default_form/default_builder'
require 'default_form/search_builder'

module DefaultForm::ViewHelper

  def default_form_for(record, options = {}, &block)
    options[:builder] = DefaultForm::DefaultBuilder
    form_for(record, options, &block)
  end

  def search_form_for(record = :q, options = {}, &block)
    options[:builder] = DefaultForm::SearchBuilder
    form_for(record, options, &block)
  end

  def default_form_with(**options, &block)
    options[:builder] = DefaultForm::DefaultBuilder
    form_with(options, &block)
  end

  def search_form_with(**options, &block)
    options[:builder] = DefaultForm::SearchBuilder
    options[:scope] = :q unless options.has_key?(:scope)
    form_with(options, &block)
  end

end

ActionView::Base.include DefaultForm::ViewHelper
