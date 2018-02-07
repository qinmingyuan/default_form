module ActionView
  module Helpers
    module Tags
      class CollectionCheckBoxes

        def render_component(builder)
          css = @options.fetch(:css, {})
          on = @options.fetch(:on, {})
          if Array(object.send(@method_name)).include? builder.value
            final_css = css[:wrapper_checkbox_checked]
          else
            final_css = css[:wrapper_checkbox]
          end

          inner = builder.check_box + builder.label
          if on[:wrapper_checkbox]
            content_tag(:div, inner, class: final_css)
          else
            inner
          end
        end

      end
    end
  end
end
