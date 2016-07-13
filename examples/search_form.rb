SearchForm.configure do |config|
  config.on.wrapper_all = false
  config.on.wrapper_input = true
  config.on.wrapper_submit = false
  config.on.offset = false

  config.css.form = 'ui form'
  config.css.wrapper_all = 'inline field'
  config.css.wrapper_input = 'field'
  config.css.wrapper_submit = ''
  config.css.offset = ''
  config.css.label = ''
  config.css.input = ''
  config.css.select = 'ui dropdown'
  config.css.submit = 'ui button'

  config.enum_name = 'enumerize'
end
