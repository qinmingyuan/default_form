require 'default_form/form_builder'

module DefaultForm::DefaultHelper

  def default_form_for(record, options = {}, &block)
    options[:builder] = DefaultForm::FormBuilder
    options[:html] ||= {}
    options[:html][:class] ||= DefaultForm.config.css.form
    options[:on] = DefaultForm.config.on
    options[:css] = DefaultForm.config.css

    form_for(record, options, &block)
  end

  def search_form_for(record, options = {}, &block)
    record = record || :q
    #record = OpenStruct.new(p.permit!.to_h)
    
    options[:builder] = DefaultForm::FormBuilder
    options[:html] ||= {}
    options[:html][:class] ||= SearchForm.config.css.form
    options[:method] ||= :get
    options[:on] = SearchForm.config.on
    options[:css] = SearchForm.config.css

    form_for(record, options, &block)
  end

end

ActionView::Base.include DefaultForm::DefaultHelper
