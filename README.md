# default_form

## Features

* 更容易定制；

* 充分利用rails内建的form builder构建helper，符合rails习惯的定制；

* 不过度包办，比如simple_form的 `f.input` 方法表面上看是方便，但是不够灵活。
我们本来就熟练掌握 input 的type知识 和 rails 的 filed 系列方法的情况下，写`text_filed` 相比写 `input` 会更灵活一些。

## 如何使用

1. 用`default_form_for` 替代 `form_for`

2. 推荐用法：用`default_form_builder' 指定 FromBuilder

default_form_builder 可以接受任意字符参数，default_form 会动态定义一个子类继承自 `DefaultForm::FormBuilder`

```ruby
class AdminAreaController < ApplicationController
  default_form_builder DefaultForm::FormBuilder
end
```

```ruby
class AdminAreaController < ApplicationController

  default_form_builder 'ExampleBuilder' do |config|
    config.on.xxx = ''
    config.css.xxx = ''
  end
  
end
```


## 如何定制

这个gem的思路只是为每个form helper method 设置了默认值, 如果不需要默认值,

1.直接覆盖即可

```ruby

f.text_filed class: 'xxx'
```


2.也可以在一个很简单的配置文件中关闭一些行为, 具体参见examples下的例子。

