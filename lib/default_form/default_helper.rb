require 'default_form/default/util'
require 'default_form/default/form_builder'

module DefaultForm
  module DefaultHelper
    include DefaultForm::Default::Util

    def default_form_for(record, options = {}, &block)
      options[:builder] = DefaultForm::Default::FormBuilder
      options[:html] ||= {}
      options[:html][:class] ||= css.form

      form_for(record, options, &block)
    end

  end
end

ActionView::Base.send :include, DefaultForm::DefaultHelper
