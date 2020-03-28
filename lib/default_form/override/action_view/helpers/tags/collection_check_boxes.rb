module ActionView
  module Helpers
    module Tags
      class CollectionCheckBoxes

        def render_component(builder)
          can = @options.fetch(:can, {})
          css = @options.fetch(:css, {})

          r = Array(object.send(@method_name)).map(&:to_s)
          if r.include? builder.value.to_s
            final_css = css[:inline_checkbox_checked]
          else
            final_css = css[:inline_checkbox]
          end

          inner = builder.check_box + builder.label
          if can[:wrap_checkbox]
            content_tag(:div, inner, class: final_css)
          else
            inner
          end
        end

      end
    end
  end
end
