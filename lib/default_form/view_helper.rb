# frozen_string_literal: true

require 'default_form/default_builder'
require 'default_form/search_builder'

module DefaultForm::ViewHelper

  def form_object(record = nil, builder: DefaultForm::DefaultBuilder, **options)
    object_name = options[:as].to_s
    
    if object_name.blank? && record.is_a?(ActiveRecord::Base)
      object_name = record.class.base_class.model_name.param_key
    end
    
    builder.new(object_name, record, self, options)
  end
  alias_method :default_form_object, :form_object

  def form_with(**options, &block)
    if options[:builder].is_a?(String)
      options[:builder] = options[:builder].safe_constantize
    end
    options[:builder] ||= DefaultForm::DefaultBuilder
    options[:scope] = '' unless options.key?(:scope)
    options[:url] ||= url_for
    
    super(options, &block)
  end

end

ActiveSupport.on_load :action_view do
 include DefaultForm::ViewHelper
end
