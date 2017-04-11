function validRequired(self_dom) {
  $(self_dom).parent().addClass('error');
}

function validPattern(self_dom) {
  $(self_dom).parent().addClass('error');
}

function clearValid(self_dom) {
  $(self_dom).parent().removeClass('error');
}