module ActionView
  module Helpers
    module Tags
      class CollectionRadioButtons

        def render_component(builder)
          can = @options.fetch(:can, {})
          css = @options.fetch(:css, {})

          r = Array(object.send(@method_name)).map(&:to_s)
          if r.include? builder.value.to_s
            final_css = css[:inline_radio_checked]
          else
            final_css = css[:inline_radio]
          end

          inner = builder.radio_button + builder.label
          if can[:wrap_radio]
            content_tag(:div, inner, class: final_css)
          else
            inner
          end
        end

      end
    end
  end
end
