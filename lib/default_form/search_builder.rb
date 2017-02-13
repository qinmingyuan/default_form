require 'default_form/builder/helper'

class DefaultForm::SearchBuilder < ActionView::Helpers::FormBuilder
  include DefaultForm::Builder::Helper

  def initialize(object_name, object, template, options)
    @params = template.params

    if params[object_name].present?
      params[object_name].permit!
      params[object_name].reject! { |_, value| value.blank? }
      object = ActiveSupport::OrderedOptions.new
      params[object_name].keys.each do |k|
        object[k] = params[object_name][k]
      end
    end

    options[:html] ||= {}
    options[:html][:class] ||= SearchForm.config.css.form
    options[:html][:method] ||= :get

    @origin_on = SearchForm.config.on.merge(options[:on] || {})
    @origin_css = SearchForm.config.css.merge(options[:css] || {})

    super
  end

end

