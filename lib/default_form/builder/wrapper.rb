module DefaultForm::Builder
  module Wrapper

    def wrapper_all(inner, method = nil, on:)
      final_on = origin_on.merge(on || {})

      if method && object_has_errors?(method)
        final_css = origin_css[:wrapper_all_error]
      else
        final_css = origin_css[:wrapper_all]
      end

      if final_on[:wrapper_all]
        content_tag(:div, inner, class: final_css)
      else
        inner
      end
    end

    def wrapper_input(inner, on:)
      final_on = origin_on.merge(on || {})

      if final_on[:wrapper_input]
        content_tag(:div, inner, class: origin_css[:wrapper_input])
      else
        inner
      end
    end

    def wrapper_submit(inner, on:)
      final_on = origin_on.merge(on || {})

      if final_on[:wrapper_submit]
        content_tag(:div, inner, class: origin_css[:wrapper_submit])
      else
        inner
      end
    end

    def offset(text = '')
      if origin_on[:offset]
        content_tag(:label, text, class: origin_css[:offset])
      else
        ''
      end
    end

    def object_has_errors?(method)
      object.respond_to?(:errors) && object.errors.respond_to?(:[]) && object.errors[method].present?
    end

  end
end

