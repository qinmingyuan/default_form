require 'default_form/builder/helper'
require 'default_form/config/search'

class DefaultForm::SearchBuilder < ActionView::Helpers::FormBuilder
  include DefaultForm::Builder::Helper

  def initialize(object_name, object, template, options)
    @origin_on = SearchForm.config.on.merge(options[:on] || {})
    @origin_css = SearchForm.config.css.merge(options[:css] || {})
    @params = template.params
    _values = Hash(@params.permit(object_name => {})[object_name])

    object ||= ActiveSupport::InheritableOptions.new(_values.symbolize_keys)

    if object.is_a?(ActiveRecord::Base)
      object.assign_attributes _values.slice(*object.attribute_names)
    end

    options[:skip_default_ids] = origin_on.skip_default_ids
    options[:local] ||= true unless options[:remote]
    options[:method] ||= 'get'
    options[:html] ||= {}
    options[:html][:class] ||= origin_css.form

    super
  end

end

