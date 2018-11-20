// depend on semantic-ui

HTMLInputElement.prototype.validForm = function() {
  var self = $(this);
  self.parent().addClass('error');
  self.parent().popup({
    position: 'right center',
    className: {
      popup: 'ui inverted popup'
    },
    content: 'Please check ' + this.name
  }).popup('show');
};

HTMLInputElement.prototype.clearValid = function() {
  var self = $(this);
  self.parent().removeClass('error');
  self.parent().popup('destroy');
};


