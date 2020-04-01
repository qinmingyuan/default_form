# frozen_string_literal: true

module DefaultForm::Builder::Default
  VALIDATIONS = [
    :required,
    :pattern,
    :min, :max, :step,
    :maxlength
  ].freeze

  def default_label(method)
    if object.is_a?(ActiveRecord::Base)
      object.class.human_attribute_name(method)
    end
  end

  def default_help(method)
    if object.is_a?(ActiveRecord::Base)
      object.class.help_i18n(method)
    end
  end

  def default_value(method)
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
    end
  end

  def default_placeholder(method)
    if object.is_a?(ActiveRecord::Base)
      object.class.human_attribute_name(method)
    end
  end

  def default_options(method = nil, options = {})
    default_without_method(options)

    # search 应返回默认 params 中对应的 value
    if options.dig(:can, :autofilter)
      options[:value] = default_value(method) unless options.key?(:value) || options.dig(:can, :autocomplete)
    end

    if options.dig(:can, :placeholder)
      options[:placeholder] = default_placeholder(method) unless options.key?(:placeholder)
    end

    options[:label] = default_label(method) unless options.key?(:label)

    valid_key = options.keys.map(&:to_sym) & VALIDATIONS
    if valid_key.present?
      options[:data] ||= {}
      options[:data][:valid] = true unless options[:data].key?(:valid)
    end

    options
  end

  def default_without_method(options = {})
    options[:can] ||= {}
    options[:can].with_defaults!(origin_can)
    options[:css] ||= {}
    options[:css].with_defaults!(origin_css)
  end

end
