require 'default_form/builder/helper'
require 'default_form/config/search'

class DefaultForm::SearchBuilder < ActionView::Helpers::FormBuilder
  include DefaultForm::Builder::Helper
  include ActiveSupport::Configurable
  config_accessor :class_on do
    SearchForm.config.on
  end
  config_accessor :class_css do
    SearchForm.config.css
  end


  def initialize(object_name, object, template, options)
    @origin_on = class_on.merge(options[:on] || {})
    @origin_css = class_css.merge(options[:css] || {})
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

