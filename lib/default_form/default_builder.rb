# frozen_string_literal: true

require 'default_form/builder/helper'
require 'default_form/config'

class DefaultForm::DefaultBuilder < ActionView::Helpers::FormBuilder
  include DefaultForm::Builder::Helper

  def initialize(object_name, object, template, options)
    set = YAML.load_file DefaultForm::Engine.root.join('config/default_form.yml')
    @origin_on = set.dig(options[:theme], :on)
    @origin_css = set.dig(options[:theme], :css)
    @origin_on.merge!(options[:on] || {})
    @origin_css.merge!(options[:css] || {})
    @params = template.params
    _values = Hash(@params.permit(object_name => {})[object_name])
    object ||= ActiveSupport::InheritableOptions.new(_values.symbolize_keys)
    if object.is_a?(ActiveRecord::Base)
      object.assign_attributes _values.slice(*object.attribute_names)
    end
    
    if options[:class] && options[:class].start_with?('new', 'edit')
      options[:class] = origin_css[:form]
    end
    options[:class] = origin_css[:form] unless options.key?(:class)

    options[:skip_default_ids] = origin_on[:skip_default_ids]
    options[:local] = origin_on[:local]
    options[:method] = set.dig(options[:theme], :method)

    super
  end

  def submit_default_value
    I18n.t 'helpers.submit.search'
  end

end

