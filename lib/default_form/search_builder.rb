require 'default_form/builder/helper'
require 'default_form/config/search'

class DefaultForm::SearchBuilder < ActionView::Helpers::FormBuilder
  include DefaultForm::Builder::Helper

  def initialize(object_name, object, template, options)
    @origin_on = SearchForm.config.on.merge(options[:on] || {})
    @origin_css = SearchForm.config.css.merge(options[:css] || {})
    @params = template.params

    if params[object_name].present?
      object = ActiveSupport::OrderedOptions.new
      params[object_name].keys.each do |k|
        object[k] = params[object_name][k] if params[object_name][k].present?
      end
    end
    
    options[:html] ||= {}
    options[:html][:class] ||= origin_css.form
    options[:html][:method] ||= :get
    
    super
  end

end

