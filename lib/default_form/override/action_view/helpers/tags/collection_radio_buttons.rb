module ActionView
  module Helpers
    module Tags
      class CollectionRadioButtons

        def render_component(builder)
          css = @options.fetch(:css, {})
          on = @options.fetch(:on, {})
          # if Array(object.send(@method_name)).include? builder.value
          #   final_css = css[:inline_checkbox_checked]
          # else
          #   final_css = css[:inline_checkbox]
          # end

          inner = builder.check_box + builder.label
          if on[:wrapper_radio]
            content_tag(:div, inner, class: css[:wrapper_radio])
          else
            inner
          end
        end

      end
    end
  end
end
