# frozen_string_literal: true

require_relative 'wrap'
require_relative 'default'

module DefaultForm::Builder::Helper
  include DefaultForm::Builder::Wrap
  include DefaultForm::Builder::Default

  INPUT_FIELDS = [
    :text_field,
    :password_field,
    :color_field,
    :search_field,
    :telephone_field,
    :phone_field,
    :time_field,
    :datetime_field,
    :datetime_local_field,
    :month_field,
    :week_field,
    :url_field,
    :email_field,
    :range_field,
    :text_area,
    :date_select
  ].freeze

  def fields(scope = nil, model: nil, **options, &block)
    options[:theme] ||= theme
    super
  end

  def label(method, text = nil, options = {}, &block)
    settings = extract_settings(options)
    options[:class] = settings.dig(:css, :label) unless options.key?(:class)

    if text.nil? && object.is_a?(ActiveRecord::Base)
      text = object.class.human_attribute_name(method)
    end

    super
  end

  def submit(value = nil, options = {})
    settings = extract_settings(options)
    options[:class] = settings.dig(:css, :submit) unless options.key?(:class)

    submit_content = wrap_submit(super, settings: settings)
    wrap_all offset(settings: settings) + submit_content, settings: settings
  end

  def check_box(method, options = {}, checked_value = '1', unchecked_value = '0')
    settings = extract_settings(options)
    options[:class] = settings.dig(:css, :checkbox) unless options.key?(:class)

    label_content = label(method, settings.delete(:label), class: nil)
    checkbox_content = wrap_checkbox(super + label_content, settings: settings)

    wrap_all offset(settings: settings) + checkbox_content, method, settings: settings
  end

  def collection_check_boxes(method, collection, value_method, text_method, options = {}, html_options = {}, &block)
    settings = extract_settings(options)

    label_content = default_label(method, settings: settings)
    checkboxes_content = wrap_checkboxes(super, settings: settings)

    wrap_all label_content + checkboxes_content, method, settings: settings
  end

  def radio_button(method, tag_value, options = {})
    settings = extract_settings(options)
    options[:class] = settings.dig(:css, :radio) unless options.key?(:class)
    default_options(method, options, settings: settings)

    label_content = default_label(method, settings: settings)
    value_content = label(method, tag_value, class: nil)
    radio_content = wrap_radio(super + value_content, settings: settings)

    wrap_all label_content + radio_content, method, settings: settings
  end

  def collection_radio_buttons(method, collection, value_method, text_method, options = {}, html_options = {}, &block)
    settings = extract_settings(options)

    label_content = default_label(method, settings: settings)
    radios_content = wrap_radios(super, settings: settings)

    wrap_all label_content + radios_content, method, settings: settings
  end

  def select(method, choices = nil, options = {}, html_options = {}, &block)
    settings = extract_settings(options)
    options[:selected] ||= default_value(method)
    html_options[:class] = if html_options[:multiple]
      settings.dig(:css, :multi_select)
    else
      settings.dig(:css, :select)
    end unless html_options.key?(:class)
    options[:include_blank] = I18n.t('helpers.select.prompt') if options[:include_blank] == true

    xxx(super, method, settings)
  end

  def collection_select(method, collection, value_method, text_method, options = {}, html_options = {})
    settings = extract_settings(options)
    html_options[:class] = if html_options[:multiple]
      settings.dig(:css, :multi_select)
    else
      settings.dig(:css, :select)
    end unless html_options.key?(:class)
    options[:include_blank] = I18n.t('helpers.select.prompt') if options[:include_blank] == true

    xxx(super, method, settings)
  end

  def time_zone_select(method, priority_zones = nil, options = {}, html_options = {})
    settings = extract_settings(options)
    html_options[:class] = if html_options[:multiple]
      settings.dig(:css, :multi_select)
    else
      settings.dig(:css, :select)
    end unless html_options.key?(:class)

    xxx(super, method, settings)
  end

  def time_select(method, options = {}, html_options = {})
    settings = extract_settings(options)
    html_options[:class] = settings.dig(:css, :select) unless html_options.key?(:class)

    xxx(super, method, settings)
  end

  def file_field(method, options = {})
    settings = extract_settings(options)

    xxx(super, method, settings)
  end

  def hidden_field(method, options = {})
    settings = extract_settings(options)
    options[:autocomplete] = settings.dig(:can, :autocomplete) unless options.key?(:autocomplete)
    super
  end

  def date_field(method, options = {})
    settings = xx(method, options) do
      if method.match?(/(date)/)
        real_method = method.to_s.sub('(date)', '')
        options[:onchange] = 'assignDefault()' if object.column_for_attribute(real_method).type == :datetime
        options[:value] = object.read_attribute(real_method)&.to_date
      end
    end
    xxx(super, method, settings)
  end

  def number_field(method, options = {})
    settings = xx(method, options) do
      options[:step] = default_step(method) unless options.key?(:step)
    end
    xxx(super, method, settings)
  end

  def xx(method, options = {})
    settings = extract_settings(options)
    default_options(method, options, settings: settings)

    if block_given?
      yield method, options
    end

    settings
  end

  def xxx(super_content, method, settings)
    label_content = default_label(method, settings: settings)
    input_content = wrap_input(super_content, method, can: settings.fetch(:can, {}), css: settings.fetch(:css, {}))

    wrap_all label_content + input_content, method, settings: settings
  end

  INPUT_FIELDS.each do |selector|
    class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
      def #{selector}(method, options = {})
        settings = xx(method, options)
        xxx(super, method, settings)  
      end
    RUBY_EVAL
  end

end
