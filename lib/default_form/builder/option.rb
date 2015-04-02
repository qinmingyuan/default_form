module DefaultForm
  module Builder
    module Option

      def choices_hash(method, choices)
        @method = method.to_s

        if choices.is_a?(Array) && choices.flatten.size == choices.size
          choices.map! { |i| [i18n(i), i]}
        end

        choices
      end

      def i18n(value)
        I18n.t i18n_keys(value)
      end

      def i18n_keys(value)
        key_enum = DefaultForm.config.enum_name
        key_object = self.object_name
        key_method = @method
        key_value = value.to_s

        key_enum + '.' + key_object + '.' + key_method + '.' + key_value
      end

    end  # Require
  end  # Helpers
end  # DefaultForm
