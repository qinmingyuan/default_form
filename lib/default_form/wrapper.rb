module DefaultForm::Wrapper

  def wrapper_all(inner)
    if on.wrapper_all
      content_tag(:div, inner, class: css.wrapper_all)
    else
      inner
    end
  end

  def wrapper_input(inner)
    if on.wrapper_input
      content_tag(:div, inner, class: css.wrapper_input)
    else
      inner
    end
  end

  def wrapper_submit(inner)
    if on.wrapper_submit
      content_tag(:div, inner, class: css.wrapper_submit)
    else
      inner
    end
  end

  def offset(text = '')
    if on.offset
      content_tag(:div, text, class: css.offset)
    else
      ''
    end
  end

  def on
    DefaultForm.config.on
  end

  def css
    DefaultForm.config.css
  end

end
