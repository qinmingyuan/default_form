require 'default_form/builder/wrapper'
class DefaultForm::FormBuilder < ActionView::Helpers::FormBuilder
  include DefaultForm::Builder::Wrapper
  attr_reader :origin_on, :origin_css
  class_attribute :input_fields
  delegate :content_tag, :params, to: :@template

  self.input_fields = [
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

  def initialize(object_name, object, template, options)
    @origin_on = options[:on]
    @origin_css = options[:css]
    super
  end

  def fields_for(record_name, record_object = nil, fields_options = {}, &block)
    fields_options[:on] = DefaultForm.config.on.merge(options[:on] || {})
    fields_options[:css] = DefaultForm.config.css.merge(options[:css] || {})

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
    custom_on = options.delete(:on)

    submit_content = wrapper_submit(super, on: custom_on)
    wrapper_all offset.html_safe + submit_content, on: custom_on
  end

  def check_box(method, options = {}, checked_value = '1', unchecked_value = '0')
    options[:css] ||= {}
    options[:css][:label] ||= ''
    label_content = label(method, options.delete(:label), options.extract!(:on, :css))
    options[:class] ||= 'hidden'
    custom_on = options.delete(:on)

    checkbox_content = content_tag(:div, super + label_content, class: origin_css[:checkbox])
    wrapper_all offset.html_safe + checkbox_content, method, on: custom_on
  end

  def collection_check_boxes(method, collection, value_method, text_method, options = {}, html_options = {}, &block)
    label_content = label(method, options.delete(:label), options.slice(:on, :css))
    custom_on = options.delete(:on)

    checkboxes_content = wrapper_input(super, on: custom_on)
    wrapper_all label_content + checkboxes_content, method, on: custom_on
  end

  def select(method, choices = nil, options = {}, html_options = {}, &block)
    label_content = label(method, options.delete(:label), options.slice(:on, :css))
    html_options[:class] ||= origin_css[:select]
    options[:selected] ||= params[options[:as]]&.fetch(method, '')  # for search
    custom_on = options.delete(:on)

    input_content = wrapper_input(super, on: custom_on)
    wrapper_all label_content + input_content, method, on: custom_on
  end

  def collection_select(method, collection, value_method, text_method, options = {}, html_options = {})
    label_content = label(method, options.delete(:label), options.slice(:on, :css))
    html_options[:class] ||= origin_css[:select]
    custom_on = options.delete(:on)

    input_content = wrapper_input(super, on: custom_on)

    wrapper_all label_content + input_content, method, on: custom_on
  end

  def file_field(method, options = {})
    label_content = label(method, options.delete(:label), options.slice(:on, :css))
    custom_on = options.delete(:on)

    input_content = wrapper_input(super, on: custom_on)

    wrapper_all label_content + input_content, method, on: custom_on
  end

  input_fields.each do |selector|
    class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
      def #{selector}(method, options = {})
        label_content = label(method, options.delete(:label), options.slice(:on, :css))      
        options[:class] ||= origin_css[:input]
        custom_on = options.delete(:on)

        input_content = wrapper_input(super, on: custom_on)
       
        wrapper_all label_content + input_content, method, on: custom_on
      end
    RUBY_EVAL
  end

end