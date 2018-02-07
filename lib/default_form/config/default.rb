require 'active_support/configurable'

module DefaultForm
  include ActiveSupport::Configurable

  configure do |config|
    config.on = ActiveSupport::OrderedOptions.new
    config.css = ActiveSupport::OrderedOptions.new

    config.css.form = 'ui form'

    config.on.wrapper_all = true
    config.css.wrapper_all = 'inline fields'
    config.css.wrapper_all_error = 'inline fields error'

    config.on.offset = true
    config.css.offset = 'six wide field'
    config.css.label = 'six wide field'

    config.on.wrapper_input = true
    config.css.wrapper_input = 'six wide field'
    config.css.input = nil
    config.css.select = 'ui fluid dropdown'
    config.css.muilti_select = 'six wide field'
    config.css.checkbox = 'ui toggle checkbox'

    config.on.wrapper_submit = false
    config.css.wrapper_submit = nil
    config.css.submit = 'ui button'

    config.on.autocomplete = true
    config.on.skip_default_ids = false

    config.enum_key = ->(o, attribute){ "#{o.i18n_scope}.attributes.#{o.model_name.i18n_key}/#{attribute}" }
  end

end