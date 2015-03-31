require 'default_form/util'
require 'default_form/form_builder'

module DefaultForm
  module Helper
    include DefaultForm::Util

    def default_form_for(record, options = {}, &block)
      options[:builder] = DefaultForm::FormBuilder
      options[:html] ||= {}
      options[:html][:class] ||= css.form

      form_for(record, options, &block)
    end

  end
end

ActionView::Base.send :include, DefaultForm::Helper
