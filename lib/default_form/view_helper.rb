# frozen_string_literal: true

require 'default_form/default_builder'
require 'default_form/search_builder'

module DefaultForm::ViewHelper

  def form_object(record = nil, builder: DefaultForm::DefaultBuilder, **options)
    object_name = options[:as].to_s
    if options[:index]
      object_name.delete_suffix! "[#{options[:index]}]"
    end
    
    if object_name.blank? && record.is_a?(ActiveRecord::Base)
      object_name = record.class.base_class.model_name.param_key
    end
    
    builder.new(object_name, record, self, options)
  end
  alias_method :default_form_object, :form_object

  def default_form_with(**options, &block)
    options[:builder] ||= DefaultForm::DefaultBuilder
    form_with(options, &block)
  end

  def search_form_with(**options, &block)
    options[:builder] ||= DefaultForm::SearchBuilder
    options[:scope] = '' unless options.key?(:scope)
    options[:url] ||= url_for
    form_with(options, &block)
  end

end

ActiveSupport.on_load :action_view do
 include DefaultForm::ViewHelper
end
