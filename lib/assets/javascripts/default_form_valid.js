// depend on semantic-ui

function validRequired(self_dom) {
  var self = $(self_dom)
  self.parent().addClass('error');
  self.parent().popup({
    position: 'right center',
    className: {
      popup: 'ui inverted popup'
    },
    content: 'Please enter ' + self[0].name
  }).popup('show');
}

function validPattern(self_dom) {
  $(self_dom).parent().addClass('error');
}

function clearValid(self_dom) {
  $(self_dom).parent().removeClass('error');
  $(self_dom).parent().popup('destroy');
}