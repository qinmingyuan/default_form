HTMLInputElement.prototype.validForm = function() {
  var self = $(this)
  self.parent().parent().addClass('weui-cell_warn');
  self.parent().parent().append('<i class="weui-icon-warn"></i>');
}

HTMLInputElement.prototype.clearValid = function() {
  var self = $(this)
  self.parent().parent().removeClass('weui-cell_warn');
  self.parent().next('.weui-icon-warn').remove();
}