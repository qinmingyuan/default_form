module DefaultForm::ModelHelper

  def options_i18n(attribute)
    h = I18n.t enum_key(attribute)

    if h.is_a? Hash
      h.invert
    else
      {}
    end
  end

  def enum_i18n(attribute, value)
    h = I18n.t enum_key(attribute)

    v = nil
    if h.is_a?(Hash)
      v = h[value.to_s.to_sym]
    end

    if value.blank?
      v = ''
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