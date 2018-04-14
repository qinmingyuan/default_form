// depend on semantic-ui

function validForm(self_dom) {
  var self = $(self_dom)
  self.parent().addClass('error');
  self.parent().popup({
    position: 'right center',
    className: {
      popup: 'ui inverted popup'
    },
    content: 'Please check ' + self_dom.name
  }).popup('show');
}

function clearValid(self_dom) {
  $(self_dom).parent().removeClass('error');
  $(self_dom).parent().popup('destroy');
}