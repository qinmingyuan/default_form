require 'default_form/default_builder'
require 'default_form/search_builder'

module DefaultForm::ViewHelper

  def default_form_for(record, options = {}, &block)
    options[:builder] = DefaultForm::DefaultBuilder
    options[:html] ||= {}
    options[:html][:class] ||= DefaultForm.config.css.form
    
    form_for(record, options, &block)
  end

  def search_form_for(record = :q, options = {}, &block)
    options[:builder] = DefaultForm::SearchBuilder
    form_for(record, options, &block)
  end

end

ActionView::Base.include DefaultForm::ViewHelper
