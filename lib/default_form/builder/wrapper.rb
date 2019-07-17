# frozen_string_literal: true

module DefaultForm::Builder::Wrapper

  def wrapper_input(inner, method, settings: {})
    on = settings.fetch(:on, {})
    css = settings.fetch(:css, {})
    
    if on[:wrapper_input]
      if on[:wrapper_input_id]
        content_tag(:div, inner, class: css[:wrapper_input], id: wrapper_input_id(method))
      else
        content_tag(:div, inner, class: css[:wrapper_input])
      end
    else
      inner
    end
  end

  def wrapper_short_input(inner, method, settings: {})
    on = settings.fetch(:on, {})
    css = settings.fetch(:css, {})
    
    if on[:wrapper_input]
      if on[:wrapper_input_id]
        content_tag(:div, inner, class: css[:wrapper_short_input], id: wrapper_input_id(method))
      else
        content_tag(:div, inner, class: css[:wrapper_short_input])
      end
    else
      inner
    end
  end

  def wrapper_checkbox(inner, settings: {})
    if settings.dig(:on, :wrapper_checkbox)
      content_tag(:div, inner, class: settings.dig(:css, :wrapper_checkbox))
    else
      inner
    end
  end

  def wrapper_checkboxes(inner, settings: {})
    if settings.dig(:on, :wrapper_checkboxes)
      content_tag(:div, inner, class: settings.dig(:css, :wrapper_checkboxes))
    else
      inner
    end
  end

  def wrapper_radio(inner, settings: {})
    if settings.dig(:on, :wrapper_radio)
      content_tag(:div, inner, class: settings.dig(:css, :wrapper_radio))
    else
      inner
    end
  end

  def wrapper_radios(inner, settings: {})
    if settings.dig(:on, :wrapper_radios)
      content_tag(:div, inner, class: settings.dig(:css, :wrapper_radios))
    else
      inner
    end
  end

  def wrapper_submit(inner, settings: {})
    if settings.dig(:on, :wrapper_submit)
      content_tag(:div, inner, class: settings.dig(:css, :wrapper_submit))
    else
      inner
    end
  end

  def wrapper_all(inner, method = nil, settings: {})
    on = settings.fetch(:on, {})
    css = settings.fetch(:css, {})
    
    if method && object_has_errors?(method)
      final_css = css[:wrapper_all_error]
    elsif settings[:required]
      final_css = css[:wrapper_all_required]
    else
      final_css = css[:wrapper_all]
    end

    if on[:wrapper_all]
      if method
        help_text = default_help(method)
        inner += help_tag(help_text, css[:help_icon]) if help_text
      end
      
      if method && on[:wrapper_all_id]
        content_tag(:div, inner, class: final_css, id: wrapper_all_id(method))
      else
        content_tag(:div, inner, class: final_css)
      end
    else
      inner
    end
  end

  def offset(text = '', settings: {})
    if settings.dig(:on, :offset)
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

  def wrapper_all_id(method)
    "#{wrapper_id(method)}_wrapper"
  end

  def wrapper_input_id(method)
    "#{wrapper_id(method)}_input"
  end

  def wrapper_id(method)
    on = @object_name.gsub(/\]\[|[^-a-zA-Z0-9:.]/, '_').sub(/^_|_$/, '')
    m = method.to_s.gsub(/[^-a-zA-Z0-9:.]/, '_').sub(/^_|_$/, '')
    [on, m].join('_')
  end

end
