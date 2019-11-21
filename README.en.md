# default_form

Rails form helpers with default wrap;

## description
less code, just use rails's form helper methods your know.
With `default_form`

but still powerful as (simple_form)[https://github.com/plataformatec/simple_form].

## features
* less config, very less DSL,
* support valid
* support html5

`default_form`只是为Rails提供的一系列表单方法设置了一些默认值和行为，然后这些默认的设置可以在配置文件、controller层，from_tag方法参数，field方法参数四个级别进行 overwrite，和配置。使用`default_form`我们只需要这样写表单：

```erb
<%= f.number_field :total_amount %>
<%= f.number_field :fee_amount %>
<%= f.number_field :income_amount %>
<%= f.datetime_field :notified_at %>
<%= f.text_field :buyer_name %>
<%= f.text_field :buyer_identifier %>
<%= f.text_field :buyer_bank %>
<%= f.text_field :comment %>
<%= f.submit %>
```

## Features

* 基于Rails内建的form builder构建helper，符合rails习惯，rails使用者上手零门槛；

* 不过度包办，在我们本来就熟练掌握 input 的 type 知识和 rails 的 filed 系列方法的情况下，写`text_filed` 相比simple_form的 `input` 写法会更灵活一些，代码表达更清晰。

* Custom more easily, small study costing；

## 如何使用

2.用`default_form_builder' 指定 FromBuilder

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

