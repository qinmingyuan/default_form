module DefaultForm::ControllerHelper

  def self.prepended(model)
    def model.default_form_builder(builder, &block)
      if builder.is_a? String
        Object.const_set builder, Class.new(DefaultForm::DefaultBuilder)
        builder.constantize.include ActiveSupport::Configurable
        builder.constantize.config.on = ActiveSupport::OrderedOptions.new
        builder.constantize.config.css = ActiveSupport::OrderedOptions.new

        if block_given?
          yield builder.constantize.config
        end
      end
      super
    end
  end

end

ActionController::Base.prepend DefaultForm::ControllerHelper



