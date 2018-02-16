function validRequired(self_dom) {
  $(self_dom).parent().parent().addClass('weui-cell_warn');
  $(self_dom).parent().parent().append('<i class="weui-icon-warn"></i>');
}

function validPattern(self_dom) {
  $(self_dom).parent().parent().removeClass('weui-cell_warn');
  $(self_dom).parent().next('.weui-icon-warn').remove();
}

function clearValid(self_dom) {
  $(self_dom).parent().parent().removeClass('weui-cell_warn');
  $(self_dom).parent().next('.weui-icon-warn').remove();
}