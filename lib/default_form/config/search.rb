require 'active_support/configurable'

module SearchForm
  include ActiveSupport::Configurable

  configure do |config|
    config.on = ActiveSupport::OrderedOptions.new
    config.on.wrapper_all = false
    config.on.wrapper_input = true
    config.on.wrapper_submit = false
    config.on.offset = false

    config.css = ActiveSupport::OrderedOptions.new
    config.css.form = 'ui form'
    config.css.wrapper_all = 'inline field'
    config.css.wrapper_input = 'field'
    config.css.wrapper_submit = ''
    config.css.offset = ''
    config.css.label = ''
    config.css.input = ''
    config.css.select = ''
    config.css.submit = 'ui button'

    config.enum_name = 'enumerize'
  end

end