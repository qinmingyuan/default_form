module DefaultForm
  class Engine < ::Rails::Engine

    config.action_view.field_error_proc = Proc.new do |html_tag, instance|
      html_tag
    end
    
  end

  module Builder

  end
end
