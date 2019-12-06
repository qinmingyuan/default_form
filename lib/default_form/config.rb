# frozen_string_literal: true

require 'active_support/configurable'

module DefaultForm
  include ActiveSupport::Configurable
  configure do |config|
    config.theme = 'default'
  end
end
