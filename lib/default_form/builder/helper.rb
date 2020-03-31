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

  def label(method, options = {}, &block)
    default_without_method(options)
    options[:class] = options.dig(:css, :label) unless options.key?(:class)

    if options.dig(:can, :label)

    else
      return ''.html_safe
    end
    inner = label(method, settings.delete(:label), class: settings.dig(:css, :label))


    wrap('label', super, options: options)
  end

  def submit(value = nil, options = {})
    default_without_method(options)
    options[:class] = options.dig(:css, :submit) unless options.key?(:class)

    submit_content = wrap('submit', super, options: options)
    wrap_all offset(options: options) + submit_content, can: options[:can], css: options[:css], required: options[:required]
  end

  def check_box(method, options = {}, checked_value = '1', unchecked_value = '0')
    default_without_method(options)
    options[:class] = options.dig(:css, :checkbox) unless options.key?(:class)

    label_content = content_tag(:span, settings.delete(:label))
    #label_content = label(method, settings.delete(:label), class: settings.dig(:css, :checkbox_label))
    checkbox_content = wrap_checkbox(super + label_content, settings: settings)

    wrap_all offset(options: options) + checkbox_content, method, can: options[:can], css: options[:css], required: options[:required]
  end

  def collection_check_boxes(method, collection, value_method, text_method, options = {}, html_options = {}, &block)
    default_without_method(options)

    label_content = label(method, options)
    checkboxes_content = wrap('checkboxes', super, options: options)

    wrap_all label_content + checkboxes_content, method, can: options[:can], css: options[:css], required: options[:required]
  end

  def radio_button(method, tag_value, options = {})
    default_method(options)
    options[:class] = options.dig(:css, :radio) unless options.key?(:class)

    label_content = label(method, options)
    value_content = label(method, tag_value, class: nil)
    radio_content = wrap('radio', super + value_content, options: options)

    wrap_all label_content + radio_content, method, can: options[:can], css: options[:css], required: options[:required]
  end

  def collection_radio_buttons(method, collection, value_method, text_method, options = {}, html_options = {}, &block)
    default_without_method(options)

    label_content = label(method, options)
    radios_content = wrap('radios', super, options: options)

    wrap_all label_content + radios_content, method, can: options[:can], css: options[:css], required: options[:required]
  end

  def select(method, choices = nil, options = {}, html_options = {}, &block)
    default_without_method(options)
    options[:selected] ||= default_value(method)
    html_options[:class] = if html_options[:multiple]
      options.dig(:css, :multi_select)
    else
      options.dig(:css, :select)
    end unless html_options.key?(:class)
    options[:include_blank] = I18n.t('helpers.select.prompt') if options[:include_blank] == true

    xxx(super, method, options)
  end

  def collection_select(method, collection, value_method, text_method, options = {}, html_options = {})
    default_without_method(options)
    html_options[:class] = if html_options[:multiple]
      options.dig(:css, :multi_select)
    else
      options.dig(:css, :select)
    end unless html_options.key?(:class)
    options[:include_blank] = I18n.t('helpers.select.prompt') if options[:include_blank] == true

    xxx(super, method, options)
  end

  def time_zone_select(method, priority_zones = nil, options = {}, html_options = {})
    default_without_method(options)
    html_options[:class] = if html_options[:multiple]
      options.dig(:css, :multi_select)
    else
      options.dig(:css, :select)
    end unless html_options.key?(:class)

    xxx(super, method, options)
  end

  def time_select(method, options = {}, html_options = {})
    default_without_method(options)
    html_options[:class] = options.dig(:css, :select) unless html_options.key?(:class)

    xxx(super, method, options)
  end

  def file_field(method, options = {})
    default_without_method(options)

    xxx(super, method, options)
  end

  def hidden_field(method, options = {})
    default_without_method(options)
    options[:autocomplete] = options.dig(:can, :autocomplete) unless options.key?(:autocomplete)
    super
  end

  def date_field(method, options = {})
    xx(method, options) do
      if method.match?(/(date)/)
        real_method = method.to_s.sub('(date)', '')
        options[:onchange] = 'assignDefault()' if object.column_for_attribute(real_method).type == :datetime
        options[:value] = object.read_attribute(real_method)&.to_date
      end
    end
    xxx(super, method, options)
  end

  def number_field(method, options = {})
    xx(method, options) do
      options[:step] = default_step(method) unless options.key?(:step)
    end
    xxx(super, method, options)
  end

  def xx(method, options = {})
    default_options(method, options)

    if block_given?
      yield method, options
    end
  end

  def xxx(super_content, method, options)
    label_content = label(method, options)
    input_content = wrap_input(super_content, method, can: options[:can], css: options[:css])

    wrap_all label_content + input_content, method, can: options[:can], css: options[:css], required: options[:required]
  end

  INPUT_FIELDS.each do |selector|
    class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
      def #{selector}(method, options = {})
        xx(method, options)
        xxx(super, method, options)  
      end
    RUBY_EVAL
  end

end
