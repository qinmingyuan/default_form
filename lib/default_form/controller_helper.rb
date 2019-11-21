
require 'default_form/form_builder'
module DefaultForm::ControllerHelper
  extend ActiveSupport::Concern
  included do
    default_form_builder DefaultForm::FormBuilder
  end
  
end


ActiveSupport.on_load :action_controller_base do
  include DefaultForm::ControllerHelper
end
