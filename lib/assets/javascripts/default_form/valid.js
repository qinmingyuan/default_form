// depend on semantic-ui

HTMLInputElement.prototype.validForm = function() {
  var self = $(this);
  var label;
  var locale = document.querySelector('html').lang;

  if (this.labels.length >0) {
    label = this.labels[0].innerText;
  } else {
    label = this.dataset['label'];
  }

  if (locale === 'en') {
    text = 'Please check ' + label;
  } else {
    text = '请检查' + label;
  }
  self.parent().addClass('error');
  self.parent().popup({
    position: 'right center',
    className: {
      popup: 'ui inverted popup'
    },
    content: text
  }).popup('show');
};

HTMLInputElement.prototype.clearValid = function() {
  var self = $(this);
  self.parent().removeClass('error');
  self.parent().popup('destroy');
};


