# frozen_string_literal: true

module DefaultForm::Builder::Wrap

  def wrap_input(inner, method, settings: {})
    can = settings.fetch(:can, {})
    css = settings.fetch(:css, {})

    if can[:wrap_input]
      if can[:wrap_input_id]
        content_tag(:div, inner, class: css[:wrap_input], id: wrap_input_id(method))
      else
        content_tag(:div, inner, class: css[:wrap_input])
      end
    else
      inner
    end
  end

  def wrap_checkbox(inner, settings: {})
    if settings.dig(:can, :wrap_checkbox)
      content_tag(:div, inner, class: settings.dig(:css, :wrap_checkbox))
    else
      inner
    end
  end

  def wrap_checkboxes(inner, settings: {})
    if settings.dig(:can, :wrap_checkboxes)
      content_tag(:div, inner, class: settings.dig(:css, :wrap_checkboxes))
    else
      inner
    end
  end

  def wrap_radio(inner, settings: {})
    if settings.dig(:can, :wrap_radio)
      content_tag(:div, inner, class: settings.dig(:css, :wrap_radio))
    else
      inner
    end
  end

  def wrap_radios(inner, settings: {})
    if settings.dig(:can, :wrap_radios)
      content_tag(:div, inner, class: settings.dig(:css, :wrap_radios))
    else
      inner
    end
  end

  def wrap_submit(inner, settings: {})
    if settings.dig(:can, :wrap_submit)
      content_tag(:div, inner, class: settings.dig(:css, :wrap_submit))
    else
      inner
    end
  end

  def wrap_all(inner, method = nil, settings: {})
    can = settings.fetch(:can, {})
    css = settings.fetch(:css, {})

    if method && object_has_errors?(method)
      final_css = css[:wrap_all_error]
    elsif settings[:required]
      final_css = css[:wrap_all_required]
    else
      final_css = css[:wrap_all]
    end

    if can[:wrap_all]
      if method
        help_text = default_help(method)
        inner += help_tag(help_text, css[:help_icon]) if help_text
      end

      if method && can[:wrap_all_id]
        content_tag(:div, inner, class: final_css, id: wrap_all_id(method))
      else
        content_tag(:div, inner, class: final_css)
      end
    else
      inner
    end
  end

  def offset(text = '', settings: {})
    if settings.dig(:can, :offset)
      content_tag(:div, text, class: settings.dig(:css, :offset))
    else
      ''.html_safe
    end
  end

  def help_tag(text, css)
    content_tag(:span, data: { tooltip: text }) do
      content_tag(:i, nil, class: css)
    end
  end

  def object_has_errors?(method)
    object.respond_to?(:errors) && object.errors.respond_to?(:[]) && object.errors[method].present?
  end

  def wrap_all_id(method)
    "#{wrap_id(method)}_wrap"
  end

  def wrap_input_id(method)
    "#{wrap_id(method)}_input"
  end

  def wrap_id(method)
    [@object_name, method].map! do |i|
      i.to_s.gsub(/\]\[|[^-a-zA-Z0-9:.]/, '_').sub(/^_|_$/, '')
    end.join('_')
  end

end
