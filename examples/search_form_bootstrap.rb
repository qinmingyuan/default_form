SearchForm.configure do |config|
  config.css.form = 'form-inline'

  config.on.wrapper_all = true
  config.css.wrapper_all = 'form-group'

  config.on.wrapper_input = false
  config.css.wrapper_input = 'col-sm-10'

  config.on.wrapper_submit = false
  config.css.wrapper_submit = 'col-sm-offset-2 col-sm-10'

  config.on.offset = false
  config.css.offset = ''
  config.css.label = 'sr-only'

  config.css.input = 'form-control'
  config.css.select = 'ui dropdown nine wide field'
  config.css.muilti_select = 'nine wide field'
  config.css.checkbox = 'checkbox'
  config.css.submit = 'btn btn-default'

  config.css.wrapper_checkbox_checked = 'checkbox-inline'
  config.css.wrapper_checkbox = 'checkbox-inline'
end