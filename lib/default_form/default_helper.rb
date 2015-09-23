require 'default_form/form_builder'

module DefaultForm
  module DefaultHelper

    def default_form_for(record, options = {}, &block)
      options[:builder] = DefaultForm::FormBuilder
      options[:html] ||= {}
      options[:html][:class] ||= default_css.form

      form_for(record, options, &block)
    end

    def search_form_for(record, options = {}, &block)
      record = record || :q

      options[:builder] = DefaultForm::FormBuilder
      options[:html] ||= {}
      options[:html][:class] ||= search_css.form
      options[:method] ||= :get

      form_for(record, options, &block)
    end

    private
    def default_css
      DefaultForm.config.css
    end

    def search_css
      SearchForm.config.css
    end

    def on
      DefaultForm.config.on

      SearchForm.config.on
    end

    def css
      DefaultForm.config.css

      SearchForm.config.css

    end




  end
end

ActionView::Base.send :include, DefaultForm::DefaultHelper
