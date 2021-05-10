module ActionView
  module Helpers
    module Tags
      class CollectionRadioButtons

        def render_component(builder)
          origin = @options.fetch(:origin, {})

          r = Array(object.send(@method_name)).map(&:to_s)
          if r.include? builder.value.to_s
            final_css = origin[:inline_radio_checked]
          else
            final_css = origin[:inline_radio]
          end

          inner = builder.radio_button + builder.label
          content_tag(:label, inner, class: final_css)
        end

      end
    end
  end
end
