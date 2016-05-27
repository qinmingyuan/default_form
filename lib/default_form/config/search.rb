require 'active_support/configurable'

module SearchForm
  include ActiveSupport::Configurable

  configure do |config|
    config.on = ActiveSupport::OrderedOptions.new
    config.css = ActiveSupport::OrderedOptions.new

    config.on.offset = false

    config.on.wrapper_all = false
    config.css.wrapper_all = 'inline field'

    config.on.wrapper_input = true
    config.css.wrapper_input = 'field'

    config.on.wrapper_submit = false
    config.css.wrapper_submit = ''

    config.css.form = 'ui form'
    config.css.offset = ''
    config.css.label = ''
    config.css.input = ''
    config.css.select = ''
    config.css.submit = 'ui button'

    config.enum_name = 'enumerize'
  end

end