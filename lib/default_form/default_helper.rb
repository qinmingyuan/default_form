require 'default_form/default/form_builder'

module DefaultForm
  module DefaultHelper

    def default_form_for(record, options = {}, &block)
      options[:builder] = DefaultForm::Default::FormBuilder
      options[:html] ||= {}
      options[:html][:class] ||= default_css.form

      form_for(record, options, &block)
    end

    private
    def default_css
      DefaultForm.config.css
    end

  end
end

ActionView::Base.send :include, DefaultForm::DefaultHelper
