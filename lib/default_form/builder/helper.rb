# frozen_string_literal: true

require 'default_form/builder/wrapper'
require 'default_form/builder/default'

module DefaultForm::Builder::Helper
  include DefaultForm::Builder::Wrapper
  include DefaultForm::Builder::Default
  attr_accessor :params
  attr_reader :origin_on, :origin_css
  delegate :content_tag, to: :@template

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

  def fields_for(record_name, record_object = nil, fields_options = {}, &block)
    fields_options[:on] = origin_on.merge(fields_options[:on] || {})
    fields_options[:css] = origin_css.merge(fields_options[:css] || {})
    super
  end

  def fields(scope = nil, model: nil, **options, &block)
    options[:on] = origin_on.merge(options[:on] || {})
    options[:css] = origin_css.merge(options[:css] || {})

    super
  end

  def label(method, text = nil, options = {}, &block)
    custom_config = extra_config(options)
    options[:class] ||= custom_config.dig(:css, :label)
    
    super
  end

  def submit(value = nil, options = {})
    custom_config = extra_config(options)
    options[:class] ||= custom_config.dig(:css, :submit)

    submit_content = wrapper_submit(super, on: custom_config[:on], css: custom_config[:css])
    wrapper_all offset(on: custom_config[:on], css: custom_config[:css]) + submit_content, on: custom_config[:on], css: custom_config[:css]
  end

  def check_box(method, options = {}, checked_value = '1', unchecked_value = '0')
    custom_config = extra_config(options)
    options[:class] ||= custom_config.dig(:css, :checkbox)

    label_content = default_label(method, custom_config)
    checkbox_content = wrapper_checkbox(super + label_content, on: custom_config[:on], css: custom_config[:css])

    wrapper_all offset(on: custom_config[:on], css: custom_config[:css]) + checkbox_content, method, on: custom_config[:on], css: custom_config[:css]
  end

  def collection_check_boxes(method, collection, value_method, text_method, options = {}, html_options = {}, &block)
    custom_config = extra_config(options)

    label_content = default_label(method, custom_config)
    checkboxes_content = wrapper_checkboxes(super, on: custom_config[:on], css: custom_config[:css])

    wrapper_all label_content + checkboxes_content, method, on: custom_config[:on], css: custom_config[:css]
  end

  def radio_button(method, tag_value, options = {})
    custom_config = extra_config(options)
    options[:class] ||= custom_config.dig(:css, :radio)
    default_options(method, options, custom_config)

    label_content = default_label(method, custom_config)
    value_content = label(method, tag_value, class: nil)
    radio_content = wrapper_radio(super + value_content, on: custom_config[:on], css: custom_config[:css])

    wrapper_all label_content + radio_content, method, on: custom_config[:on], css: custom_config[:css]
  end

  def collection_radio_buttons(method, collection, value_method, text_method, options = {}, html_options = {}, &block)
    custom_config = extra_config(options)

    label_content = default_label(method, custom_config)
    radios_content = wrapper_radios(super, on: custom_config[:on], css: custom_config[:css])

    wrapper_all label_content + radios_content, method, on: custom_config[:on], css: custom_config[:css]
  end

  def select(method, choices = nil, options = {}, html_options = {}, &block)
    custom_config = extra_config(options)
    options[:selected] ||= default_value(method)
    html_options[:class] ||= if html_options[:multiple]
      custom_config.dig(:css, :multi_select)
    else
      custom_config.dig(:css, :select)
    end
    options[:include_blank] = I18n.t('helpers.select.prompt') if options[:include_blank] == true

    label_content = default_label(method, custom_config)
    input_content = wrapper_input(super, method, on: custom_config[:on], css: custom_config[:css])

    wrapper_all label_content + input_content, method, on: custom_config[:on], css: custom_config[:css]
  end

  def collection_select(method, collection, value_method, text_method, options = {}, html_options = {})
    custom_config = extra_config(options)
    html_options[:class] ||= if html_options[:multiple]
      custom_config.dig(:css, :multi_select)
    else
      custom_config.dig(:css, :select)
    end
    options[:include_blank] = I18n.t('helpers.select.prompt') if options[:include_blank] == true

    label_content = default_label(method, custom_config)
    input_content = wrapper_input(super, method, on: custom_config[:on], css: custom_config[:css])

    wrapper_all label_content + input_content, method, on: custom_config[:on], css: custom_config[:css]
  end

  def time_zone_select(method, priority_zones = nil, options = {}, html_options = {})
    custom_config = extra_config(options)
    html_options[:class] ||= if html_options[:multiple]
      custom_config.dig(:css, :multi_select)
    else
      custom_config.dig(:css, :select)
    end

    label_content = default_label(method, custom_config)
    input_content = wrapper_input(super, method, on: custom_config[:on], css: custom_config[:css])

    wrapper_all label_content + input_content, method, on: custom_config[:on], css: custom_config[:css]
  end

  def time_select(method, options = {}, html_options = {})
    custom_config = extra_config(options)
    html_options[:class] ||= custom_config.dig(:css, :select)

    label_content = default_label(method, custom_config)
    input_content = wrapper_short_input(super, method, on: custom_config[:on], css: custom_config[:css])

    wrapper_all label_content + input_content, method, on: custom_config[:on], css: custom_config[:css]
  end

  def file_field(method, options = {})
    custom_config = extra_config(options)

    label_content = default_label(method, custom_config)
    input_content = wrapper_input(super, method, on: custom_config[:on], css: custom_config[:css])

    wrapper_all label_content + input_content, method, on: custom_config[:on], css: custom_config[:css]
  end

  def hidden_field(method, options = {})
    custom_config = extra_config(options)
    options[:autocomplete] = custom_config.dig(:on, :autocomplete) unless options.key?(:autocomplete)
    super
  end

  def date_field(method, options = {})
    custom_config = extra_config(options)
    default_options(method, options, custom_config)

    if method.match?(/(date)/)
      real_method = method.to_s.sub('(date)', '')
      options[:onchange] = 'assignDefault()' if object.column_for_attribute(real_method).type == :datetime
      options[:value] = object.read_attribute(real_method)&.to_date
    end

    label_content = default_label(method, custom_config)
    input_content = wrapper_input(super, method, on: custom_config[:on], css: custom_config[:css])

    wrapper_all label_content + input_content, method, on: custom_config[:on], css: custom_config[:css]
  end

  def number_field(method, options = {})
    custom_config = extra_config(options)
    default_options(method, options, custom_config)
    options[:step] ||= default_step(method)

    label_content = default_label(method, custom_config)
    input_content = wrapper_input(super, method, on: custom_config[:on], css: custom_config[:css])

    wrapper_all label_content + input_content, method, on: custom_config[:on], css: custom_config[:css]
  end

  INPUT_FIELDS.each do |selector|
    class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
      def #{selector}(method, options = {})
        custom_config = extra_config(options)
        default_options(method, options, custom_config)

        label_content = default_label(method, custom_config)
        input_content = wrapper_input(super, method, on: custom_config[:on], css: custom_config[:css])

        wrapper_all label_content + input_content, method, on: custom_config[:on], css: custom_config[:css]
      end
    RUBY_EVAL
  end

end
