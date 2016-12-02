DefaultForm.configure do |config|
  config.css.form = ''

  config.on.wrapper_all = true
  config.css.wrapper_all = 'form-group'

  config.on.wrapper_input = false
  config.css.wrapper_input = ''

  config.on.wrapper_submit = false
  config.css.wrapper_submit = ''

  config.on.offset = false
  config.css.offset = ''

  config.css.label = ''
  config.css.input = 'form-control'
  config.css.select = 'ui dropdown nine wide field'
  config.css.muilti_select = 'nine wide field'
  config.css.checkbox = 'checkbox'
  config.css.submit = 'btn btn-default'
end