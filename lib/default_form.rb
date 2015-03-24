require 'default_form/version'
require 'default_form/config'
require 'default_form/form_builder'

module DefaultForm
  module Helper

    def default_form_for(record, options = {}, &block)
      options.merge!(builder: DefaultForm::FormBuilder)

      options[:html] ||= {}
      options[:html][:class] = [options[:html][:class], css.form].compact.join(" ")

      form_for(record, options, &block)
    end



    private

    def on
      DefaultForm.config.on
    end

    def css
      DefaultForm.config.css
    end

  end
end

ActionView::Base.send :include, DefaultForm::Helper
