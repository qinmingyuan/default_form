# frozen_string_literal: true

require 'active_support/configurable'

module DefaultForm
  include ActiveSupport::Configurable
  configure do |config|
    config.theme = 'default'
    config.help_tag = ->(text, css) {
      content_tag(:span, data: { tooltip: text }) do
        content_tag(:i, nil, class: css)
      end
    }
  end
end
