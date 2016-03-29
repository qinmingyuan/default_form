require 'default_form/version'
require 'default_form/default_helper'
require 'default_form/config/default'
require 'default_form/config/search'

class ActiveRecord::Base

  def self.options_i18n(attribute)
    h = I18n.t "#{self.i18n_scope}.attributes.#{self.model_name.i18n_key}/#{attribute}"

    if h.is_a? Hash
      h.invert
    else
      {}
    end
  end

  def self.enum_i18n(attribute, value)
    h = I18n.t "#{self.i18n_scope}.attributes.#{self.model_name.i18n_key}/#{attribute}"

    if h.is_a?(Hash) && h.present?
      h[value.to_sym]
    else
      human_attribute_name(value)
    end
  end


end
