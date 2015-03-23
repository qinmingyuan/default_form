require 'active_support/configurable'

module DefaultForm
  include ActiveSupport::Configurable

  configure do |config|
    config.on = ActiveSupport::OrderedOptions.new
    config.on.wrapper_all = true
    config.on.wrapper_input = false
    config.on.wrapper_submit = false
    config.on.offset = true

    config.css = ActiveSupport::OrderedOptions.new
    config.css.form = 'ui form'
    config.css.wrapper_all = 'inline field'
    config.css.wrapper_input = ''
    config.css.wrapper_submit = ''
    config.css.offset = 'six wide field'
    config.css.label = 'six wide field'
    config.css.input = 'nine wide field'
    config.css.submit = 'ui button'
  end

end