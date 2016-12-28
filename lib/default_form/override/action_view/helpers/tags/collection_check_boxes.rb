module ActionView
  module Helpers
    module Tags
      class CollectionCheckBoxes

        def render_component(builder)
          if object.send(@method_name).include? builder.value
            final_css = 'ui teal label checkbox'
          else
            final_css = 'ui label checkbox'
          end

          inner = builder.check_box + builder.label
          content_tag(:div, inner, class: final_css)
        end

      end
    end
  end
end
