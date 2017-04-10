module DefaultForm
  class Engine < ::Rails::Engine

    initializer 'default_form.add_generator_templates' do |app|
      app.config.assets.paths.push File.expand_path('../../assets/javascripts', __FILE__)
    end

  end
end
