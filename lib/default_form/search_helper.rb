require 'default_form/search/util'
require 'default_form/search/form_builder'

module DefaultForm
  module SearchHelper
    include DefaultForm::Search::Util

    def search_form_for(record, options = {}, &block)
      record = record || :q

      options[:builder] = DefaultForm::Search::FormBuilder
      options[:html] ||= {}
      options[:html][:class] ||= css.form
      options[:method] ||= :get

      form_for(record, options, &block)
    end

  end
end

ActionView::Base.send :include, DefaultForm::SearchHelper
