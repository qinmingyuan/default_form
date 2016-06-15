module DefaultForm::ModelHelper

  def options_i18n(attribute)
    h = I18n.t "#{self.i18n_scope}.attributes.#{self.model_name.i18n_key}/#{attribute}"

    if h.is_a? Hash
      h.invert
    else
      {}
    end
  end

  def enum_i18n(attribute, value)
    h = I18n.t "#{self.i18n_scope}.attributes.#{self.model_name.i18n_key}/#{attribute}"

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

end

ActiveRecord::Base.extend DefaultForm::ModelHelper