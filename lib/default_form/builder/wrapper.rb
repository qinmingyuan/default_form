module DefaultForm::Builder
  module Wrapper

    def label(method, text = nil, options = {}, &block)
      options[:class] ||= css[:label]
      super
    end

    def wrapper_all(inner, method = nil)
      if method && object_has_errors?(method)
        final_css = css[:wrapper_all_error]
      else
        final_css = css[:wrapper_all]
      end

      if on[:wrapper_all]
        content_tag(:div, inner, class: final_css)
      else
        inner
      end
    end

    def wrapper_input(inner)
      if on[:wrapper_input]
        content_tag(:div, inner, class: css[:wrapper_input])
      else
        inner
      end
    end

    def wrapper_submit(inner)
      if on[:wrapper_submit]
        content_tag(:div, inner, class: css[:wrapper_submit])
      else
        inner
      end
    end

    def offset(text = '')
      if on[:offset]
        content_tag(:label, text, class: css[:offset])
      else
        ''
      end
    end

    def object_has_errors?(method)
      object.respond_to?(:errors) && object.errors.respond_to?(:[]) && object.errors[method].present?
    end

  end
end

