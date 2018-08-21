require 'default_form/builder/helper'
require 'default_form/config/search'

class DefaultForm::SearchBuilder < ActionView::Helpers::FormBuilder
  include DefaultForm::Builder::Helper

  def initialize(object_name, object, template, options)
    @origin_on = SearchForm.config.on.merge(options[:on] || {})
    @origin_css = SearchForm.config.css.merge(options[:css] || {})
    @params = template.params

    object ||= ActiveSupport::OrderedOptions.new

    if object.is_a?(ActiveRecord::Base)
      object.assign_attributes @params.permit(object_name => {}).fetch(object_name, {}).slice(*object.attribute_names)
    elsif object.is_a?(ActiveSupport::OrderedOptions)
      object.merge! @params[object_name]
    end

    options[:local] ||= true unless options[:remote]
    options[:method] ||= 'get'
    options[:html] ||= {}
    options[:html][:class] ||= origin_css.form

    super
  end

end

