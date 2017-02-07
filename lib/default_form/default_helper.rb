require 'default_form/form_builder'

module DefaultForm::DefaultHelper

  def default_form_for(record, options = {}, &block)
    options[:builder] = DefaultForm::FormBuilder
    options[:html] ||= {}
    options[:html][:class] ||= DefaultForm.config.css.form
    options[:html][:autocomplete] ||= 'off'
    options[:on] = DefaultForm.config.on.merge(options[:on] || {})
    options[:css] = DefaultForm.config.css.merge(options[:css] || {})

    form_for(record, options, &block)
  end

  def search_form_for(record, options = {}, &block)
    record = record || :q

    case record
    when String, Symbol
      params[record] ||= {}
      params[record].permit!
      params[record].reject! { |_, value| value.blank? }
    end

    options[:builder] = DefaultForm::FormBuilder
    options[:html] ||= {}
    options[:html][:class] ||= SearchForm.config.css.form
    options[:html][:autocomplete] ||= 'off'
    options[:method] ||= :get
    options[:on] = SearchForm.config.on.merge(options[:on] || {})
    options[:css] = SearchForm.config.css.merge(options[:css] || {})
    options[:as] = record
    options[:url] = request.path

    result = ActiveSupport::OrderedOptions.new

    params[record].keys.each do |k|
      result[k] = params[record][k]
    end

    form_for(result, options, &block)
  end

end

ActionView::Base.include DefaultForm::DefaultHelper
