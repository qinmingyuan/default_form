module ActionView
  module Helpers
    module Tags
      class CollectionRadioButtons

        def render_component(builder)
          css = @options.fetch(:css, {})
          on = @options.fetch(:on, {})
          if Array(object.send(@method_name)).include? builder.value
            final_css = css[:inline_radio_checked]
          else
            final_css = css[:inline_radio]
          end

          inner = builder.radio_button + builder.label
          if on[:wrapper_radio]
            content_tag(:div, inner, class: final_css)
          else
            inner
          end
        end

      end
    end
  end
end
