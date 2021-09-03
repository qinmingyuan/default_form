import DefaultValidController from './default_valid'
import DatetimeController from './datetime'
import FieldController from './field';
import WeuiFormController from './valid_weui';

application.register('field', FieldController)
application.register('datetime', DatetimeController)
application.register('default_valid', DefaultValidController)
application.register('weui_form', WeuiFormController)
