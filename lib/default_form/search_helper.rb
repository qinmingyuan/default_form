require 'default_form/form_builder'

module DefaultForm
  module SearchHelper

    def search_form_for(record, options = {}, &block)
      record = record || :q

      options[:builder] = DefaultForm::Search::FormBuilder
      options[:html] ||= {}
      options[:html][:class] ||= search_css.form
      options[:method] ||= :get

      form_for(record, options, &block)
    end

    private
    def search_css
      SearchForm.config.css
    end

    def on
      SearchForm.config.on
    end

    def css
      SearchForm.config.css
    end

  end
end

ActionView::Base.send :include, DefaultForm::SearchHelper
