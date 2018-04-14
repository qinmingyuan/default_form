module DefaultForm
  class Engine < ::Rails::Engine

    config.action_view.field_error_proc = ->(html_tag, instance){ html_tag }

  end

  module Builder

  end
end
