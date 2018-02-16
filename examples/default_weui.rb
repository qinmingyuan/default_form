DefaultForm.configure do |config|
  config.css.form = 'weui-cells weui-cells_form'

  config.on.wrapper_all = true
  config.css.wrapper_all = 'weui-cell'
  config.css.wrapper_all_error = 'inline field error'

  config.on.wrapper_input = true
  config.css.wrapper_input = 'weui-cell__bd'

  config.on.wrapper_submit = true
  config.css.wrapper_submit = 'weui-btn-area'

  config.on.offset = false
  config.css.offset = ''

  config.css.label = 'weui-label'
  config.css.input = 'weui-input'
  config.css.select = 'weui-select'
  config.css.muilti_select = 'weui-select'
  config.css.checkbox = 'checkbox'
  config.css.submit = 'weui-btn weui-btn_primary'

  config.enum_key = ->(o, attribute){ "#{o.i18n_scope}.status.#{attribute}" }
end