# frozen_string_literal: true

require 'active_support/configurable'

module DefaultForm
  include ActiveSupport::Configurable

  configure do |config|
    config.theme = 'default'
    config.help_tag = ->(app, text) {
      app.content_tag(:span, aria: { label: text }) do
        app.content_tag(:i, nil, class: 'fas fa-question-circle')
      end
    }
  end

end
