require 'active_support/configurable'

module SearchForm
  include ActiveSupport::Configurable

  configure do |config|
    config.on = ActiveSupport::OrderedOptions.new
    config.css = ActiveSupport::OrderedOptions.new

    config.css.form = 'ui form'

    config.on.wrapper_all = false
    config.css.wrapper_all = 'inline field'
    config.css.wrapper_all_error = 'inline field error'

    config.on.wrapper_input = true
    config.css.wrapper_input = 'field'
    config.css.input = ''
    config.css.select = ''
    config.css.muilti_select = ''
    config.css.checkbox = ''

    config.on.wrapper_submit = false
    config.css.wrapper_submit = ''
    config.css.submit = 'ui button'

    config.on.offset = false
    config.css.offset = ''
    config.css.label = ''

    config.on.autocomplete = true

    config.enum_key = ->(o, attribute){ "#{o.i18n_scope}.attributes.#{o.model_name.i18n_key}/#{attribute}" }
  end

end