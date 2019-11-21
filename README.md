# DefaultForm

[English](README.en.md)

`default_form`只是为Rails提供的一系列表单方法设置了一些默认值和行为，然后这些默认的设置可以在配置文件、controller层，from_tag方法参数，field方法参数四个级别进行 overwrite，和配置。

## 初衷
在现代的前后端分离架构中，前端通过在 js 中构建 ajax 请求跟后端服务器进行交互。在传统的 Web 开发中，form 表单是前端与后端通信的唯一路径，可以说是传统 Web 开发的核心。

## 说明
使用`default_form`我们只需要这样写表单：
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

## 特性

* 基于Rails内建的form builder构建helper，符合rails习惯，rails使用者上手零门槛；

* 不过度包办，在我们本来就熟练掌握 input 的 type 知识和 rails 的 filed 系列方法的情况下，写`text_filed` 相比simple_form的 `input` 写法会更灵活一些，代码表达更清晰。

* 更容易定制，更小的学习成本；

## 如何使用

1. 在 Controller 文件中, 用 default_form_builder 指定 FromBuilder
```ruby
class AdminAreaController < ApplicationController
  default_form_builder DefaultForm::FormBuilder
end
```

2. 在 config 目录下，配置 default_form.yml 文件

3. 在 Erb 文件中，给 form_with 指定 theme 选项，默认为 theme: 'default'
```ruby
form_with(theme: 'my_theme')
```

## 如何定制

这个gem的思路只是为每个form helper method 设置了默认值, 如果不需要默认值,

1. field 级别，直接使用原生 class 写法
```ruby
f.text_filed class: 'xxx'
```

2. form 级别
```erbruby
form_with on: {  }, css: { }
```

3. 在 yml 文件中修改对应文件；
具体参见[examples](examples)下的例子。

