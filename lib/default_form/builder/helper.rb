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
    :date_field,
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
    fields_options[:on] = origin_on.merge(options[:on] || {})
    fields_options[:css] = origin_css.merge(options[:css] || {})

    super
  end

  def label(method, text = nil, options = {}, &block)
    options[:class] ||= origin_css.merge(options.delete(:css) || {}).fetch(:label)

    if text.equal?(false) || !object.is_a?(ActiveRecord::Base)
      return ''.html_safe
    elsif text.nil?
      text = object.class.human_attribute_name(method)
    end

    super
  end

  def submit(value = nil, options = {})
    options[:class] ||= origin_css[:submit]
    custom_config = options.extract!(:on, :css)

    submit_content = wrapper_submit(super, config: custom_config)
    wrapper_all offset(config: custom_config) + submit_content, config: custom_config
  end

  def check_box(method, options = {}, checked_value = '1', unchecked_value = '0')
    options[:class] ||= 'hidden'
    custom_config = options.extract!(:on, :css)
    custom_config[:css] ||= {}
    custom_config[:css][:label] ||= ''
    css = origin_css.merge(custom_config[:css])

    label_content = label(method, options.delete(:label), custom_config)

    checkbox_content = content_tag(:div, super + label_content, class: css[:checkbox])
    wrapper_all offset.html_safe + checkbox_content, method, config: custom_config
  end

  def collection_check_boxes(method, collection, value_method, text_method, options = {}, html_options = {}, &block)
    label_content = label(method, options.delete(:label), options.slice(:on, :css))
    custom_config = options.extract!(:on, :css)

    checkboxes_content = wrapper_input(super, config: custom_config)
    wrapper_all label_content + checkboxes_content, method, config: custom_config
  end

  def select(method, choices = nil, options = {}, html_options = {}, &block)
    label_content = label(method, options.delete(:label), options.slice(:on, :css))
    html_options[:class] ||= origin_css[:select]
    options[:selected] ||= params[object_name]&.fetch(method, '')  # for search
    custom_config = options.extract!(:on, :css)

    input_content = wrapper_input(super, config: custom_config)
    wrapper_all label_content + input_content, method, config: custom_config
  end

  def collection_select(method, collection, value_method, text_method, options = {}, html_options = {})
    label_content = label(method, options.delete(:label), options.slice(:on, :css))
    html_options[:class] ||= origin_css[:select]
    custom_config = options.extract!(:on, :css)

    input_content = wrapper_input(super, config: custom_config)
    wrapper_all label_content + input_content, method, config: custom_config
  end

  def file_field(method, options = {})
    label_content = label(method, options.delete(:label), options.slice(:on, :css))
    custom_config = options.extract!(:on, :css)

    input_content = wrapper_input(super, config: custom_config)
    wrapper_all label_content + input_content, method, config: custom_config
  end

  def hidden_field(method, options = {})
    options[:autocomplete] = 'off'
    super
  end

  INPUT_FIELDS.each do |selector|
    class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
      def #{selector}(method, options = {})
        label_content = label(method, options.delete(:label), options.slice(:on, :css))      
        options[:class] ||= origin_css[:input]
        
        valid_key = (options.keys & VALIDATIONS).sort.join('_')
        if valid_key
          options[:onblur] ||= 'checkValidity()'
          options[:oninput] ||= 'clearValid(this)'
          options[:oninvalid] ||= 'valid' + valid_key.camelize + '(this)'
        end

        custom_config = options.extract!(:on, :css)
        input_content = wrapper_input(super, config: custom_config)
        wrapper_all label_content + input_content, method, config: custom_config
      end
    RUBY_EVAL
  end

end