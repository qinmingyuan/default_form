require 'active_support/configurable'

module DefaultForm
  include ActiveSupport::Configurable

  configure do |config|
    config.on = ActiveSupport::OrderedOptions.new
    config.css = ActiveSupport::OrderedOptions.new

    config.css.form = 'ui form'

    config.on.wrapper_all = true
    config.css.wrapper_all = 'inline fields'
    config.css.wrapper_all_error = 'inline error fields'
    config.css.wrapper_all_required = 'inline required fields'

    config.on.label = true
    config.on.offset = true
    config.css.label = 'six wide field'
    config.css.offset = 'six wide field'

    config.on.wrapper_input = true
    config.css.wrapper_input = 'six wide field'
    config.css.input = nil
    config.css.select = 'ui fluid search dropdown'
    config.css.multi_select = 'ui fluid search dropdown'

    config.on.wrapper_checkbox = true
    config.css.checkbox = 'hidden'
    config.css.wrapper_checkbox = 'ui toggle checkbox'

    config.on.wrapper_checkboxes = true
    config.css.wrapper_checkboxes = 'six wide field ui labels'
    config.css.inline_checkbox = 'ui label checkbox'
    config.css.inline_checkbox_checked = 'ui teal label checkbox'

    config.on.wrapper_submit = false
    config.css.wrapper_submit = nil
    config.css.submit = 'ui button'

    config.on.autocomplete = true
    config.on.skip_default_ids = false
    config.on.placeholder = false

    config.enum_key = ->(o, attribute){ "#{o.i18n_scope}.attributes.#{o.base_class.model_name.i18n_key}/#{attribute}" }
  end

end