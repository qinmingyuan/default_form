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
      col = object.class.column_for_attribute(method)
      scale = col.scale || col.limit
      0.1.to_d.power(scale.to_i)
    end
  end

  def default_options(method = nil, options = {})
    # search 应返回默认 params 中对应的 value
    on = options.delete(:on) || {}
    on.reverse_merge! on_options
    if on[:autofilter] && !(options.key?(:value) || on[:autocomplete])
      options[:value] = default_value(method)
    end

    if on[:placeholder] && !options.key?(:placeholder)
      options[:placeholder] = default_label(method)
    end

    options[:label] = default_label(method) unless options.key?(:label)

    valid_key = options.keys.map(&:to_sym) & VALIDATIONS
    if valid_key.present?
      options[:data] ||= {}
      options[:data][:valid] = true unless options[:data].key?(:valid)
    end
  end

  def default_without_method(options = {})
    options[:origin] ||= {}
    options[:origin].with_defaults!(origin_css)
    options[:wrap] ||= {}
    options[:wrap].with_defaults!(wrap_css)
  end

end
