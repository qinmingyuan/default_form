require 'active_support/configurable'

module SearchForm
  include ActiveSupport::Configurable

  configure do |config|
    config.on = ActiveSupport::OrderedOptions.new
    config.on.wrapper_all = true
    config.on.wrapper_input = false
    config.on.wrapper_submit = false
    config.on.offset = false

    config.css = ActiveSupport::OrderedOptions.new
    config.css.form = 'form-inline'
    config.css.wrapper_all = 'form-group'
    config.css.wrapper_input = ''
    config.css.wrapper_submit = ''
    config.css.offset = ''
    config.css.label = ''
    config.css.input = 'form-control'
    config.css.submit = 'btn btn-default btn-sm'

    config.enum_name = 'enumerize'
  end

end