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
    :file_field,
    :text_area,
    :date_select
  ].freeze

  def fields(scope = nil, model: nil, **options, &block)
    options[:theme] ||= theme
    super
  end

  def label(method, text = nil, options = {}, &block)
    default_without_method(options)
    can = options.delete(:can)
    css = options.delete(:css)
    options[:class] = css[:label] unless options.key?(:class)

    wrap('label', super, can: can, css: css)
  end

  def submit(value = nil, options = {})
    wrap_all_with(nil, options) do |can, css|
      options[:class] = css[:submit] unless options.key?(:class)

      submit_content = wrap('submit', super, can: can, css: css)
      offset(can: can, css: css) + submit_content
    end
  end

  def check_box(method, options = {}, checked_value = '1', unchecked_value = '0')
    wrap_all_with(method, options) do |can, css|
      default_options(method, options, can: can)
      options[:class] = css[:checkbox] unless options.key?(:class)
      label_text = content_tag(:span, options.delete(:label))
      checkbox_content = wrap_checkbox(super + label_text, can: can, css: css)
      input_content = wrap_input(checkbox_content, method, can: can, css: css)

      offset(can: can, css: css) + input_content
    end
  end

  def collection_check_boxes(method, collection, value_method, text_method, options = {}, html_options = {}, &block)
    default_without_method(options)

    label_content = label(method, nil, options.dup)
    checkboxes_content = wrap('checkboxes', super, can: can, css: css)

    wrap_all label_content + checkboxes_content, method, can: can, css: css, required: options[:required]
  end

  def radio_button(method, tag_value, options = {})
    wrap_with(method, options) do |_, css|
      options[:class] = css[:radio] unless options.key?(:class)
      label_content = label(method, nil, options.dup)
      value_content = label(method, tag_value, class: nil)
      wrap('radio', super + value_content, can: can, css: css)
    end
  end

  def collection_radio_buttons(method, collection, value_method, text_method, options = {}, html_options = {}, &block)
    wrap_with(method, options) do
      label_content = label(method, nil, options.dup)
      wrap('radios', super, can: can, css: css)
    end
  end

  def select(method, choices = nil, options = {}, html_options = {}, &block)
    wrap_with(method, options) do |can, css|
      options[:selected] ||= default_value(method)
      html_options[:class] = if html_options[:multiple]
        css[:multi_select]
      else
        css[:select]
      end unless html_options.key?(:class)
      options[:include_blank] = I18n.t('helpers.select.prompt') if options[:include_blank] == true

      wrap_input(super, method, can: can, css: css)
    end
  end

  def collection_select(method, collection, value_method, text_method, options = {}, html_options = {})
    wrap_with(method, options) do |can, css|
      html_options[:class] = if html_options[:multiple]
        css[:multi_select]
      else
        css[:select]
      end unless html_options.key?(:class)
      options[:include_blank] = I18n.t('helpers.select.prompt') if options[:include_blank] == true

      wrap_input(super, method, can: can, css: css)
    end
  end

  def time_zone_select(method, priority_zones = nil, options = {}, html_options = {})
    wrap_with(method, options) do |can, css|
      html_options[:class] = if html_options[:multiple]
        css[:multi_select]
      else
        css[:select]
      end unless html_options.key?(:class)

      wrap_input(super, method, can: can, css: css)
    end
  end

  def time_select(method, options = {}, html_options = {})
    wrap_with(method, options) do |_, css|
      html_options[:class] = css[:select] unless html_options.key?(:class)
      super
    end
  end

  def hidden_field(method, options = {})
    default_without_method(options)
    can = options.delete(:can)
    options.delete(:css)
    options[:autocomplete] = can[:autocomplete] unless options.key?(:autocomplete)
    super
  end

  def date_field(method, options = {})
    wrap_with(method, options) do |can, css|
      options[:class] = css[:input] unless options.key?(:class)
      if method.match?(/(date)/)
        real_method = method.to_s.sub('(date)', '')
        options[:onchange] = 'assignDefault()' if object.column_for_attribute(real_method).type == :datetime
        options[:value] = object.read_attribute(real_method)&.to_date
      end

      wrap_input(super, method, can: can, css: css)
    end
  end

  def number_field(method, options = {})
    wrap_with(method, options) do |can, css|
      options[:class] = css[:input] unless options.key?(:class)
      options[:step] = default_step(method) unless options.key?(:step)
      wrap_input(super, method, can: can, css: css)
    end
  end

  # block 应返回 input with wrapper 的内容
  def wrap_with(method, options = {})
    wrap_all_with(method, options) do |can, css|
      default_options(method, options, can: can)
      if can[:label]
        label_content = label method, options.delete(:label), options.slice(:can, :css)
      else
        options.delete(:label)
        label_content = ''.html_safe
      end
      input_content = yield can, css

      label_content + input_content
    end
  end

  # block 应返回  label_content + input_content 的内容
  def wrap_all_with(method, options)
    default_without_method(options)
    can = options.delete(:can)
    css = options.delete(:css)
    inner_content = yield can, css

    wrap_all inner_content, method, can: can, css: css, required: options[:required]
  end

  INPUT_FIELDS.each do |selector|
    class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
      def #{selector}(method, options = {})
        wrap_with(method, options) do |can, css|
          options[:class] = css[:input] unless options.key?(:class)
          wrap_input(super, method, can: can, css: css)
        end
      end
    RUBY_EVAL
  end

end
