require 'default_form/builder/wrapper'

module DefaultForm::Builder::Helper
  include DefaultForm::Builder::Wrapper
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
    :number_field,
    :range_field,
    :text_area
  ]
  VALIDATIONS = [
    :required,
    :pattern,
    :min, :max, :step,
    :maxlength
  ]

  def fields_for(record_name, record_object = nil, fields_options = {}, &block)
    fields_options[:on] = origin_on.merge(fields_options[:on] || {})
    fields_options[:css] = origin_css.merge(fields_options[:css] || {})
    super
  end

  def label(method, text = nil, options = {}, &block)
    on = origin_on.merge(options.delete(:on) || {})
    css = origin_css.merge(options.delete(:css) || {})
    options[:class] ||= css[:label]

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
    options[:class] ||= origin_css[:submit]
    custom_config = options.extract!(:on, :css)

    submit_content = wrapper_submit(super, config: custom_config)
    wrapper_all offset(config: custom_config) + submit_content, config: custom_config
  end

  def check_box(method, options = {}, checked_value = '1', unchecked_value = '0')
    options[:class] ||= origin_css[:checkbox]
    custom_config = options.extract!(:on, :css)
    custom_config[:css] ||= {}
    custom_config[:css][:label] ||= ''

    label_content = label(method, options.delete(:label), custom_config.slice(:on, :css))
    checkbox_content = wrapper_checkbox(super + label_content, config: custom_config)

    wrapper_all offset(config: custom_config) + checkbox_content, method, config: custom_config
  end

  def collection_check_boxes(method, collection, value_method, text_method, options = {}, html_options = {}, &block)
    custom_config = options.extract!(:on, :css)
    options[:on] = origin_on.merge(custom_config[:on] || {}) # todo 更细腻的参数
    options[:css] = origin_css.merge(custom_config[:css] || {})

    label_content = label(method, options.delete(:label), custom_config.slice(:on, :css))
    checkboxes_content = wrapper_checkboxes(super, config: custom_config)

    wrapper_all label_content + checkboxes_content, method, config: custom_config
  end

  def select(method, choices = nil, options = {}, html_options = {}, &block)
    options[:selected] ||= default_value(method)
    html_options[:class] ||= if html_options[:multiple]
      origin_css[:multi_select]
    else
      origin_css[:select]
    end
    custom_config = options.extract!(:on, :css)

    label_content = label(method, options.delete(:label), custom_config.slice(:on, :css))
    input_content = wrapper_input(super, config: custom_config)

    wrapper_all label_content + input_content, method, config: custom_config
  end

  def collection_select(method, collection, value_method, text_method, options = {}, html_options = {})
    html_options[:class] ||= if html_options[:multiple]
      origin_css[:multi_select]
    else
      origin_css[:select]
    end
    custom_config = options.extract!(:on, :css)

    label_content = label(method, options.delete(:label), custom_config.slice(:on, :css))
    input_content = wrapper_input(super, config: custom_config)

    wrapper_all label_content + input_content, method, config: custom_config
  end

  def file_field(method, options = {})
    custom_config = options.extract!(:on, :css)

    label_content = label(method, options.delete(:label), custom_config.slice(:on, :css))
    input_content = wrapper_input(super, config: custom_config)

    wrapper_all label_content + input_content, method, config: custom_config
  end

  def hidden_field(method, options = {})
    options[:autocomplete] = 'off'
    super
  end

  def date_field(method, options = {})
    options[:class] ||= origin_css[:input]
    unless object.is_a?(ActiveRecord::Base)
      options[:value] ||= default_value(method)
    end
    if origin_on[:placeholder]
      options[:placeholder] ||= default_placeholder(method)
    end
    custom_config = options.extract!(:on, :css)

    valid_key = (options.keys & VALIDATIONS).sort.join('_')
    if valid_key.present?
      options[:onblur] ||= 'checkValidity()'
      options[:oninput] ||= 'clearValid(this)'
      options[:oninvalid] ||= 'valid' + valid_key.camelize + '(this)'
    end

    if method.match?(/(date)/)
      real_method = method.to_s.sub('(date)', '')
      options[:onchange] = 'assignDefault(this)' if object.column_for_attribute(real_method).type == :datetime
      options[:value] = object.read_attribute(real_method)&.to_date
    end

    label_content = label(method, options.delete(:label), custom_config.slice(:on, :css))
    input_content = wrapper_input(super, config: custom_config)

    wrapper_all label_content + input_content, method, config: custom_config
  end

  INPUT_FIELDS.each do |selector|
    class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
      def #{selector}(method, options = {})
        options[:class] ||= origin_css[:input]
        unless object.is_a?(ActiveRecord::Base)
          options[:value] ||= default_value(method)
        end
        if origin_on[:placeholder]
          options[:placeholder] ||= default_placeholder(method)
        end
        custom_config = options.extract!(:on, :css)
      
        valid_key = (options.keys & VALIDATIONS).sort.join('_')
        if valid_key.present?
          options[:onblur] ||= 'checkValidity()'
          options[:oninput] ||= 'clearValid(this)'
          options[:oninvalid] ||= 'valid' + valid_key.camelize + '(this)'
        end

        label_content = label(method, options.delete(:label), custom_config.slice(:on, :css))
        input_content = wrapper_input(super, config: custom_config)

        wrapper_all label_content + input_content, method, config: custom_config
      end
    RUBY_EVAL
  end

  def default_value(method)
    if origin_on.autocomplete
      if object_name
        return params[object_name]&.fetch(method, '')
      else
        return params[method]
      end
    end
  end

  def default_placeholder(method)
    if object.is_a?(ActiveRecord::Base)
      object.class.human_attribute_name(method)
    else
      # todo
    end
  end

end