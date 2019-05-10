# frozen_string_literal: true

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
    config.css.wrapper_all_required = nil

    config.on.label = false
    config.on.offset = false
    config.css.label = nil
    config.css.offset = nil
    config.css.help_icon = nil

    config.on.wrapper_input = true
    config.css.wrapper_input = 'field'
    config.css.wrapper_short_input = 'field'
    config.css.input = nil
    config.css.select = nil
    config.css.multi_select = nil

    config.on.wrapper_checkbox = true
    config.css.checkbox = nil
    config.css.wrapper_checkbox = 'ui toggle checkbox'

    config.on.wrapper_checkboxes = true
    config.css.wrapper_checkboxes = 'six wide field ui labels'
    config.css.inline_checkbox = 'ui label checkbox'
    config.css.inline_checkbox_checked = 'ui teal label checkbox'

    config.on.wrapper_radio = true
    config.css.radio = 'hidden'
    config.css.wrapper_radio = 'ui radio checkbox'

    config.on.wrapper_radios = true
    config.css.wrapper_radios = 'six wide field ui labels'
    config.css.inline_radio = 'ui label radio checkbox'
    config.css.inline_radio_checked = 'ui teal label radio checkbox'

    config.on.wrapper_submit = true
    config.css.wrapper_submit = 'field'
    config.css.submit = 'ui blue button'

    config.on.autocomplete = true
    config.on.placeholder = true
    config.on.skip_default_ids = true

    config.enum_key = ->(o, attribute){ "#{o.i18n_scope}.enum.#{o.base_class.model_name.i18n_key}.#{attribute}" }
    config.help_key = ->(o, attribute){ "#{o.i18n_scope}.help.#{o.base_class.model_name.i18n_key}.#{attribute}" }
  end
end
