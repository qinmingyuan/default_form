// depend on semantic-ui

HTMLInputElement.prototype.validForm = function() {
  var self = $(this);
  var label;
  var locale = document.querySelector('html').lang;
  var xx = {
    zh: {
      badInput: 'ririiririrrr',
      customError: 'ririiririrrr',
      patternMismatch: 'ririiririrrr',
      rangeOverflow: 'ririiririrrr',
      rangeUnderflow: 'ririiririrrr',
      stepMismatch: 'ririiririrrr',
      tooLong: 'ririiririrrr',
      tooShort: 'ririiririrrr',
      typeMismatch: 'ririiririrrr',
      valid: 'ririiririrrr',
      valueMissing: '请输入'
    },
    en: {
      badInput: 'ririiririrrr',
      customError: 'ririiririrrr',
      patternMismatch: 'ririiririrrr',
      rangeOverflow: 'ririiririrrr',
      rangeUnderflow: 'ririiririrrr',
      stepMismatch: 'ririiririrrr',
      tooLong: 'ririiririrrr',
      tooShort: 'ririiririrrr',
      typeMismatch: 'ririiririrrr',
      valid: 'ririiririrrr',
      valueMissing: 'please enter'
    }
  };

  for (var key in this.validity) {
    if (this.validity[key]) {
      w = xx[locale][key]
    }
  }

  if (this.labels.length >0) {
    label = this.labels[0].innerText;
  } else {
    label = this.dataset['label'];
  }

  text = w + label;

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


