module DefaultForm::Builder::Default

  def default_value(method)
    if origin_on.autocomplete
      if object_name
        return params[object_name]&.fetch(method, '')
      else
        return params[method]
      end
    end
  end

  def default_step(method)
    if object.is_a?(ActiveRecord::Base)
      0.1.to_d.power(object.class.columns_hash[method.to_s]&.scale.to_i)
    else
    end
  end

  def default_placeholder(method)
    if object.is_a?(ActiveRecord::Base)
      object.class.human_attribute_name(method)
    else
      # todo
    end
  end

end
