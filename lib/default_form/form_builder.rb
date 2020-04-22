# frozen_string_literal: true

require 'default_form/builder/helper'
require 'default_form/config'

class DefaultForm::FormBuilder < ActionView::Helpers::FormBuilder
  include DefaultForm::Builder::Helper
  attr_reader :origin_css, :wrap_css, :on_options, :theme, :params
  delegate :content_tag, to: :@template

  def initialize(object_name, object, template, options)
    if options.key?(:theme)
      @theme = options[:theme].to_s
    else
      @theme = 'default'
    end
    set_file = Rails.root.join('config/default_form.yml').existence || DefaultForm::Engine.root.join('config/default_form.yml')
    set = YAML.load_file set_file
    settings = set.fetch(theme, {})
    settings.deep_symbolize_keys!

    options[:method] = settings[:method] if !options.key?(:method) && settings.key?(:method)
    options[:local] = settings[:local] if !options.key?(:local) && settings.key?(:local)
    options[:skip_default_ids] = settings[:skip_default_ids] if settings.key?(:skip_default_ids)

    @origin_css = settings.fetch(:origin, {})
    @origin_css.merge! options.fetch(:origin, {})
    @wrap_css = settings.fetch(:wrap, {})
    @wrap_css.merge! options.fetch(:wrap, {})
    @on_options = settings.extract! :autocomplete, :autofilter, :placeholder
    @on_options.merge! options.fetch(:on, {})
    @params = template.params

    _values = Hash(params.permit(object_name => {})[object_name])
    if object.is_a?(ActiveRecord::Base)
      object.assign_attributes _values.slice(*object.attribute_names)
    end

    if options[:class].to_s.start_with?('new_', 'edit_')
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

