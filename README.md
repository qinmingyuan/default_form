# default_form

## 为什么写这个gem

* simple_form 太难定制；

* 充分利用rails的form构建helper；

* 符合rails习惯的定制；

## 如何使用

1. 用`default_form_for` 替代 `form_for`

2. 用`default_form_builder' 指定 FromBuilder

```ruby
class AdminAreaController < ApplicationController
  default_form_builder DefaultForm::FormBuilder
end
```

## 如何定制

这个gem的思路只是为每个form helper method 设置了默认值, 如果不需要默认值,直接覆盖即可.也可以在一个很简单的配置文件中关闭一些行为

```ruby

    config.on.wrapper_all = true
    config.css.wrapper_all = 'inline field'

    config.on.wrapper_input = false
    config.css.wrapper_input = ''

    config.on.wrapper_submit = false
    config.css.wrapper_submit = ''

    config.on.offset = true
    config.css.offset = 'six wide field'

```

