# frozen_string_literal: true

require 'default_form/builder/helper'
require 'default_form/config'

class DefaultForm::FormBuilder < ActionView::Helpers::FormBuilder
  include DefaultForm::Builder::Helper
  attr_reader :origin_on, :origin_css, :theme
  delegate :content_tag, :params, to: :@template

  def initialize(object_name, object, template, options)
    @theme = options[:theme]
    set_file = Rails.root.join('config/default_form.yml').existence || DefaultForm::Engine.root.join('config/default_form.yml')
    set = YAML.load_file set_file
    settings = set.fetch(theme, {})

    @origin_on = settings.fetch(:on, {})
    @origin_css = settings.fetch(:css, {})
    options[:method] = settings[:method] unless options.key?(:method)
    options[:local] = settings[:local] unless options.key?(:local)
    options[:skip_default_ids] = settings[:skip_default_ids]

    @origin_on.merge! options.fetch(:on, {})
    @origin_css.merge! options.fetch(:css, {})
    _values = Hash(params.permit(object_name => {})[object_name])
    object ||= ActiveSupport::InheritableOptions.new(_values.symbolize_keys)
    if object.is_a?(ActiveRecord::Base)
      object.assign_attributes _values.slice(*object.attribute_names)
    end
    
    if options.fetch(:class, '').start_with?('new_', 'edit_')
      options[:class] = origin_css[:form]
    end
    options[:class] = origin_css[:form] unless options.key?(:class)

    super
  end

  def submit_default_value
    I18n.t "helpers.submit.#{theme}", raise: true
  rescue
    super
  end

end

