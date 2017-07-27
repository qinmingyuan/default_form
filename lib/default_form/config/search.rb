require 'active_support/configurable'

module SearchForm
  include ActiveSupport::Configurable

  configure do |config|
    config.on = ActiveSupport::OrderedOptions.new
    config.css = ActiveSupport::OrderedOptions.new

    config.css.form = 'ui form'

    config.on.wrapper_all = false
    config.css.wrapper_all = nil
    config.css.wrapper_all_error = nil

    config.on.wrapper_input = true
    config.css.wrapper_input = 'field'
    config.css.input = nil
    config.css.select = nil
    config.css.muilti_select = nil
    config.css.checkbox = nil

    config.on.wrapper_submit = false
    config.css.wrapper_submit = nil
    config.css.submit = 'ui button'

    config.on.offset = false
    config.css.offset = nil
    config.css.label = nil

    config.on.autocomplete = true

    config.enum_key = ->(o, attribute){ "#{o.i18n_scope}.attributes.#{o.model_name.i18n_key}/#{attribute}" }
  end

end