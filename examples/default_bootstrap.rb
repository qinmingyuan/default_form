DefaultForm.configure do |config|
  config.css.form = 'form-horizontal'

  config.on.wrapper_all = true
  config.css.wrapper_all = 'form-group'
  config.css.wrapper_all_error = 'form-group has-error'

  config.on.offset = false
  config.css.offset = ''
  config.css.label = 'col-sm-2 control-label'

  config.on.wrapper_input = true
  config.css.wrapper_input = 'col-sm-10'
  config.css.input = 'form-control'
  config.css.select = 'ui dropdown nine wide field'
  config.css.multi_select = 'nine wide field'

  config.on.wrapper_checkbox = true
  config.css.checkbox = 'checkbox'
  config.css.wrapper_checkbox = 'checkbox-inline'
  config.css.wrapper_checkbox_checked = 'checkbox-inline'

  config.on.wrapper_submit = true
  config.css.wrapper_submit = 'col-sm-offset-2 col-sm-10'
  config.css.submit = 'btn btn-default'
end