module DefaultForm::ModelHelper

  def options_i18n(attribute)
    h = I18n.t enum_key(attribute), default: {}

    if h.is_a?(Hash) && h.present?
      return h.invert
    end

    if h.blank?
      name = attribute.to_s.pluralize
      if respond_to?(name)
        enum_hash = public_send(name)
        h = enum_hash.keys.map { |i| [i.humanize, i] }.to_h
      end
    end

    h
  end

  def enum_i18n(attribute, value)
    h = I18n.t enum_key(attribute)

    v = nil
    if h.is_a?(Hash)
      v = h[value] ? h[value] : h[value.to_s.to_sym]
    end

    if v.nil?
      v = human_attribute_name(value)
    end

    v
  end

  def enum_key(attribute)
    DefaultForm.config.enum_key.call(self, attribute)
  end

  def self.extended(mod)
    mod.attribute_method_suffix '_i18n'

    mod.class_exec do
      def attribute_i18n(attr)
        self.class.enum_i18n attr, send(attr)
      end
    end
  end

end

ActiveRecord::Base.extend DefaultForm::ModelHelper