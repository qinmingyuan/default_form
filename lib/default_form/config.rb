# frozen_string_literal: true

require 'active_support/configurable'

SET = YAML.load_file DefaultForm::Engine.root.join('config/default_form.yml')
module DefaultForm
  include ActiveSupport::Configurable
  configure do |config|
    config.theme = 'default'
    config.enum_key = ->(o, attribute){ "#{o.i18n_scope}.enum.#{o.base_class.model_name.i18n_key}.#{attribute}" }
    config.help_key = ->(o, attribute){ "#{o.i18n_scope}.help.#{o.base_class.model_name.i18n_key}.#{attribute}" }
  end
end
