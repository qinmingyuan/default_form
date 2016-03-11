require 'default_form/version'
require 'default_form/default_helper'
require 'default_form/config/default'
require 'default_form/config/search'

class ActiveRecord::Base

  def self.options_i18n(attribute)
    h = I18n.t "#{self.i18n_scope}.attributes.#{self.model_name.i18n_key}/#{attribute}"
    h.invert
  end



end
