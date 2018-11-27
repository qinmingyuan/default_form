// depend on semantic-ui

HTMLInputElement.prototype.defaultFormValid = function() {
  var self = $(this);
  var label;
  var locale = document.querySelector('html').lang;
  var xx = {
    zh: {
      badInput: '格式不正确：',
      customError: 'ririiririrrr',
      patternMismatch: '非法的',
      rangeOverflow: 'ririiririrrr',
      rangeUnderflow: 'ririiririrrr',
      stepMismatch: 'ririiririrrr',
      tooLong: '太长了',
      tooShort: '太短了',
      typeMismatch: 'ririiririrrr',
      valid: '非法值',
      valueMissing: '请输入'
    },
    en: {
      badInput: 'ririiririrrr',
      customError: 'ririiririrrr',
      patternMismatch: 'Invalid Input: ',
      rangeOverflow: 'ririiririrrr',
      rangeUnderflow: 'ririiririrrr',
      stepMismatch: 'ririiririrrr',
      tooLong: 'Too long',
      tooShort: 'Too Short',
      typeMismatch: 'ririiririrrr',
      valid: 'Not valid',
      valueMissing: 'Please enter '
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

HTMLInputElement.prototype.defaultFormClear = function() {
  var self = $(this);
  self.parent().removeClass('error');
  self.parent().popup('destroy');
};


