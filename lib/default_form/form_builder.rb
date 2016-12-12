require 'default_form/builder/wrapper'
class DefaultForm::FormBuilder < ActionView::Helpers::FormBuilder
  include DefaultForm::Builder::Wrapper
  attr_reader :on, :css

  delegate :content_tag, :params, to: :@template

  class_attribute :input_fields
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
    @on = options[:on]
    @css = options[:css]
    super
  end

  def fields_for(record_name, record_object = nil, fields_options = {}, &block)
    fields_options[:on] = DefaultForm.config.on.merge(options[:on] || {})
    fields_options[:css] = DefaultForm.config.css.merge(options[:css] || {})

    super
  end

  def submit(value = nil, options={})
    options[:class] ||= css[:submit]

    submit_content = wrapper_submit(super)
    wrapper_all offset.html_safe + submit_content
  end

  def check_box(method, options = {}, checked_value = '1', unchecked_value = '0')
    options[:class] ||= 'hidden'
    label_content = label(method, options[:label], class: '')

    checkbox_content = content_tag(:div, super + label_content, class: css[:checkbox])
    wrapper_all offset.html_safe + checkbox_content, method
  end

  def collection_check_boxes(method, collection, value_method, text_method, options = {}, html_options = {}, &block)
    label_content = label(method, options[:label])

    checkboxes_content = wrapper_input(super)
    wrapper_all label_content + checkboxes_content, method
  end

  def select(method, choices = nil, options = {}, html_options = {}, &block)
    html_options[:class] ||= css[:select]
    options[:selected] ||= params[options[:as]]&.fetch(method, '')  # for search

    label_content = options[:label] ? label(method, options[:label]) : ''.html_safe
    input_content = wrapper_input(super)

    wrapper_all label_content + input_content, method
  end

  def collection_select(method, collection, value_method, text_method, options = {}, html_options = {})
    html_options[:class] ||= css[:select]

    label_text = options[:label]
    label_content = label_text ? label(method, label_text) : ''.html_safe
    input_content = wrapper_input(super)

    wrapper_all label_content + input_content, method
  end

  def file_field(method, options = {})
    label_text = options[:label]
    label_content = label(method, label_text)
    input_content = wrapper_input(super)

    wrapper_all label_content + input_content, method
  end

  input_fields.each do |selector|
    class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
      def #{selector}(method, options = {})
        options[:class] ||= css[:input]

        label_text = options[:label]
        unless options[:custom]
          label_content = label_text ? label(method, label_text) : ''.html_safe
          input_content = wrapper_input(super)

          wrapper_all label_content + input_content, method
        end
      end
    RUBY_EVAL
  end

end