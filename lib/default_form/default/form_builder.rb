require 'default_form/builder/wrapper'
require 'default_form/builder/require'
require 'default_form/builder/option'
require 'default_form/default/util'

class DefaultForm::Default::FormBuilder < ActionView::Helpers::FormBuilder
  include DefaultForm::Default::Util
  include DefaultForm::Builder::Wrapper
  include DefaultForm::Builder::Require
  include DefaultForm::Builder::Option

  delegate :content_tag, to: :@template

  class_attribute :input_fields
  self.input_fields = [ :text_field,
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

  def label(method, text = nil, options = {}, &block)
    options[:class] ||= css.label
    super
  end

  def submit(value = nil, options={})
    options[:class] ||= css.submit

    submit_content = wrapper_submit(super)
    wrapper_all offset.html_safe + submit_content
  end

  def check_box(method, options = {}, checked_value = "1", unchecked_value = "0")
    checkbox_content = content_tag(:label, super + options[:label].to_s)
    checkbox_content = content_tag(:div, checkbox_content, class: 'checkbox')
    checkbox_content = content_tag(:div, checkbox_content, class: 'col-sm-offset-2 col-sm-5')
    wrapper_all checkbox_content
  end

  def collection_check_boxes(method, collection, value_method, text_method, options = {}, html_options = {}, &block)
    label_content = label(method, options[:label])

    checkboxes_content = wrapper_input(super)
    wrapper_all label_content + checkboxes_content
  end

  def select(method, choices = nil, options = {}, html_options = {}, &block)
    html_options[:class] ||= css.input

    label_content = label(method, options[:label])
    choices = choices_hash(method, choices)
    input_content = wrapper_input(super)

    wrapper_all label_content + input_content
  end

  def collection_select(method, collection, value_method, text_method, options = {}, html_options = {})
    html_options[:class] ||= css.input

    label_text = options[:label]
    label_content = label(method, label_text)
    input_content = wrapper_input(super)

    wrapper_all label_content + input_content
  end

  def file_field(method, options = {})
    label_text = options[:label]
    label_content = label(method, label_text)
    input_content = wrapper_input(super)

    wrapper_all label_content + input_content
  end

  input_fields.each do |selector|
    class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
      def #{selector}(method, options = {})
        options[:class] ||= css.input

        label_text = options[:label]
        label_content = label(method, label_text)
        input_content = wrapper_input(super)

        wrapper_all label_content + input_content
      end
    RUBY_EVAL
  end

end
