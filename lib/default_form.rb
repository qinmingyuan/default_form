require 'default_form/version'
require 'default_form/default_helper'
require 'default_form/search_helper'
require 'default_form/default/config'
require 'default_form/search/config'


module DefaultForm

end

module SearchForm

end

class ActiveRecord::Base
  def self.enum_trans(attribute = defined_enums.keys.first)
    h = I18n.t "activerecord.attributes.#{self.model_name.i18n_key}/#{attribute}"
    h.invert
  end
end