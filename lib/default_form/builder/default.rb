# frozen_string_literal: true

module DefaultForm::Builder::Default
  VALIDATIONS = [
    :required,
    :pattern,
    :min, :max, :step,
    :maxlength
  ].freeze
  
  def default_label(method, settings: {})
    return ''.html_safe unless settings.dig(:on, :label)
    
    label(method, settings.delete(:label))
  end

  def default_help(method)
    if object.is_a?(ActiveRecord::Base)
      object.class.help_i18n(method)
    else
      nil
    end
  end
  
  def default_value(method)
    return unless origin_on.autocomplete
    
    if object.is_a?(ActiveRecord::Base)
      r = object.respond_to?(method) && object.send(method)
      return r if r
    end
    
    if object_name.present?
      params.dig(object_name, method)
    else
      params[method]
    end
  end

  def default_step(method)
    if object.is_a?(ActiveRecord::Base)
      0.1.to_d.power(object.class.columns_hash[method.to_s]&.scale.to_i)
    else
    end
  end

  def default_placeholder(method)
    if object.is_a?(ActiveRecord::Base)
      object.class.human_attribute_name(method)
    else
      # todo
    end
  end

  def default_options(method, options = {}, settings: {})
    options[:class] = settings.dig(:css, :input) unless options.key?(:class)

    if self.is_a?(DefaultForm::SearchBuilder)
      options[:value] = default_value(method) unless options.key?(:value)
    end
    if origin_on[:placeholder]
      options[:placeholder] = default_placeholder(method) unless options.key?(:placeholder)
    end
    default_valid(options)
  end

  def default_valid(options = {})
    valid_key = options.keys & VALIDATIONS
    if valid_key.present?
      options[:data] ||= {}
      options[:data][:valid] = true unless options[:data].key?(:valid)
    end
    options
  end

  def extract_settings(options = {})
    settings = options.extract!(:on, :css, :label, :required)
    settings[:on] ||= {}
    settings[:on].with_defaults!(origin_on)
    settings[:css] ||= {}
    settings[:css].with_defaults!(origin_css)
    settings
  end

end
