require 'active_support/configurable'

module DefaultForm
  include ActiveSupport::Configurable

  configure do |config|
    config.on = ActiveSupport::OrderedOptions.new
    config.css = ActiveSupport::OrderedOptions.new

    config.css.form = 'ui segment form'

    config.on.wrapper_all = true
    config.css.wrapper_all = 'inline field'
    config.css.wrapper_all_error = 'inline field error'

    config.on.wrapper_input = true
    config.css.wrapper_input = ''
    config.css.input = 'nine wide field'
    config.css.select = 'ui dropdown nine wide field'
    config.css.muilti_select = 'nine wide field'
    config.css.checkbox = 'ui toggle checkbox'

    config.on.wrapper_submit = false
    config.css.wrapper_submit = ''
    config.css.submit = 'ui button'

    config.on.offset = true
    config.css.offset = 'six wide field'
    config.css.label = 'six wide field'
  end

end