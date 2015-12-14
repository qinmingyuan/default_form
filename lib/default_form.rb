require 'default_form/version'
require 'default_form/default_helper'
require 'default_form/config/default'
require 'default_form/config/search'

class ActiveRecord::Base

  def self.enum_trans(attribute)
    h = I18n.t "activerecord.attributes.#{self.model_name.i18n_key}/#{attribute}"
    h.invert
  end

end
