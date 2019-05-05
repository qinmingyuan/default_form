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
  ]

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
    on = origin_on.merge(options[:on] || {})
    css = origin_css.merge(options[:css] || {})
    options = options.except(:on, :css, :required)
    options[:class] = css[:label] unless options.key?(:class)

    # label: false
    if text.equal?(false)
      return ''.html_safe
    end

    # label: ''
    if text
      return super
    end

    if on[:label]
      # no label options but label on
      if text.nil? && object.is_a?(ActiveRecord::Base)
        text = object.class.human_attribute_name(method)
      end

      super
    else
      ''.html_safe
    end
  end

  def submit(value = nil, options = {})
    custom_config = options.extract!(:on, :css)
    options[:class] ||= origin_css[:submit]

    submit_content = wrapper_submit(super, config: custom_config)
    wrapper_all offset(config: custom_config) + submit_content, config: custom_config
  end

  def check_box(method, options = {}, checked_value = '1', unchecked_value = '0')
    custom_config = extra_config(options)
    custom_config[:css][:label] ||= ''
    options[:class] ||= origin_css[:checkbox]

    label_content = label(method, options.delete(:label), custom_config)
    checkbox_content = wrapper_checkbox(super + label_content, config: custom_config)

    wrapper_all offset(config: custom_config) + checkbox_content, method, config: custom_config
  end

  def collection_check_boxes(method, collection, value_method, text_method, options = {}, html_options = {}, &block)
    custom_config = options.slice(:on, :css, :required)
    options[:on] = origin_on.merge(options[:on] || {}) # todo 更细腻的参数
    options[:css] = origin_css.merge(options[:css] || {})

    label_content = label(method, options.delete(:label), custom_config)
    checkboxes_content = wrapper_checkboxes(super, config: custom_config)

    wrapper_all label_content + checkboxes_content, method, config: custom_config
  end

  def radio_button(method, tag_value, options = {})
    custom_config = extra_config(options)
    custom_config[:on][:wrapper_all] ||= false
    default_options(method, options)
    options[:class] ||= origin_css[:radio]

    label_content = label(method, options.delete(:label), custom_config)
    value_content = label(method, tag_value, class: nil)
    radio_content = wrapper_radio(super + value_content, config: custom_config)

    wrapper_all label_content + radio_content, method, config: custom_config
  end

  def collection_radio_buttons(method, collection, value_method, text_method, options = {}, html_options = {}, &block)
    custom_config = options.slice(:on, :css, :required)
    options[:on] = origin_on.merge(options[:on] || {}) # todo 更细腻的参数
    options[:css] = origin_css.merge(options[:css] || {})

    label_content = label(method, options.delete(:label), custom_config)
    radios_content = wrapper_radios(super, config: custom_config)

    wrapper_all label_content + radios_content, method, config: custom_config
  end

  def select(method, choices = nil, options = {}, html_options = {}, &block)
    custom_config = extra_config(options)
    options[:selected] ||= default_value(method)
    html_options[:class] ||= if html_options[:multiple]
      origin_css[:multi_select]
    else
      origin_css[:select]
    end
    options[:include_blank] = I18n.t('helpers.select.prompt') if options[:include_blank] == true

    label_content = label(method, options.delete(:label), custom_config)
    input_content = wrapper_input(super, method, config: custom_config)

    wrapper_all label_content + input_content, method, config: custom_config
  end

  def collection_select(method, collection, value_method, text_method, options = {}, html_options = {})
    custom_config = extra_config(options)
    html_options[:class] ||= if html_options[:multiple]
      origin_css[:multi_select]
    else
      origin_css[:select]
    end
    options[:include_blank] = I18n.t('helpers.select.prompt') if options[:include_blank] == true

    label_content = label(method, options.delete(:label), custom_config)
    input_content = wrapper_input(super, method, config: custom_config)

    wrapper_all label_content + input_content, method, config: custom_config
  end

  def time_zone_select(method, priority_zones = nil, options = {}, html_options = {})
    custom_config = extra_config(options)
    html_options[:class] ||= if html_options[:multiple]
      origin_css[:multi_select]
    else
      origin_css[:select]
    end

    label_content = label(method, options.delete(:label), custom_config)
    input_content = wrapper_input(super, method, config: custom_config)

    wrapper_all label_content + input_content, method, config: custom_config
  end

  def time_select(method, options = {}, html_options = {})
    custom_config = extra_config(options)
    html_options[:class] ||= origin_css[:select]

    label_content = label(method, options.delete(:label), custom_config)
    input_content = wrapper_short_input(super, method, config: custom_config)

    wrapper_all label_content + input_content, method, config: custom_config
  end

  def file_field(method, options = {})
    custom_config = extra_config(options)

    label_content = label(method, options.delete(:label), custom_config)
    input_content = wrapper_input(super, method, config: custom_config)

    wrapper_all label_content + input_content, method, config: custom_config
  end

  def hidden_field(method, options = {})
    extra_config(options)
    options[:autocomplete] = origin_on[:autocomplete] unless options.key?(:autocomplete)
    super
  end

  def date_field(method, options = {})
    custom_config = extra_config(options)
    default_options(method, options)

    if method.match?(/(date)/)
      real_method = method.to_s.sub('(date)', '')
      options[:onchange] = 'assignDefault()' if object.column_for_attribute(real_method).type == :datetime
      options[:value] = object.read_attribute(real_method)&.to_date
    end

    label_content = label(method, options.delete(:label), custom_config)
    input_content = wrapper_input(super, method, config: custom_config)

    wrapper_all label_content + input_content, method, config: custom_config
  end

  def number_field(method, options = {})
    custom_config = extra_config(options)
    default_options(method, options)
    options[:step] ||= default_step(method)

    label_content = label(method, options.delete(:label), custom_config)
    input_content = wrapper_input(super, method, config: custom_config)

    wrapper_all label_content + input_content, method, config: custom_config
  end

  INPUT_FIELDS.each do |selector|
    class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
      def #{selector}(method, options = {})
        custom_config = extra_config(options)
        default_options(method, options)

        label_content = label(method, options.delete(:label), custom_config)
        input_content = wrapper_input(super, method, config: custom_config)

        wrapper_all label_content + input_content, method, config: custom_config
      end
    RUBY_EVAL
  end

end
