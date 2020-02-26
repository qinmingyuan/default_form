// depend on semantic-ui

HTMLElement.prototype.defaultFormValid = function() {
  let label
  let locale = document.querySelector('html').lang
  const i18ns = {
    zh: {
      badInput: '格式不正确：',
      customError: '输入错误',
      patternMismatch: '非法的',
      rangeOverflow: '输入错误',
      rangeUnderflow: '输入错误',
      stepMismatch: '输入错误',
      tooLong: '太长了',
      tooShort: '太短了',
      typeMismatch: '输入错误',
      valid: '非法值',
      valueMissing: '请输入'
    },
    en: {
      badInput: 'Bad Input:',
      customError: 'Custom Error:',
      patternMismatch: 'Invalid Input: ',
      rangeOverflow: 'Range Over Flow:',
      rangeUnderflow: 'Range Under Flow:',
      stepMismatch: 'Step Mismatch',
      tooLong: 'Too long',
      tooShort: 'Too Short',
      typeMismatch: 'Type Mismatch',
      valid: 'Not valid',
      valueMissing: 'Please enter:'
    }
  }

  for (let key in this.validity) {
    if (this.validity[key]) {
      w = i18ns[locale][key]
    }
  }

  if (this.labels.length >0) {
    label = this.labels[0].innerText;
  } else {
    label = this.dataset['label'];
  }

  text = w + label

  this.parentNode.classList.add('error');
  $(this.parentNode).popup({
    position: 'right center',
    className: {
      popup: 'ui inverted popup'
    },
    content: text
  }).popup('show')
}

HTMLElement.prototype.defaultFormClear = function() {
  this.parentNode.classList.remove('error')
  $(this.parentNode).popup('destroy')
}

HTMLInputElement.prototype.assignDefault = function(){
  let date = new Date(this.value)
  let _year = document.querySelector('[name="' + this.name.replace('(date)', '(1i)') + '"]')
  let _month = document.querySelector('[name="' + this.name.replace('(date)', '(2i)') + '"]')
  let _date = document.querySelector('[name="' + this.name.replace('(date)', '(3i)') + '"]')
  _year.value = date.getFullYear()
  _month.value = date.getMonth() + 1
  _date.value = date.getDate()
}

HTMLFormElement.prototype.cleanSubmit = function(){
  for (let i = 0; i < this.elements.length; i++) {
    if ( this[i].value.length === 0 ) {
      this[i].disabled = true
    }

    if ( this[i].name === 'utf8' ) {
      this[i].disabled = true
    }

    if ( this[i].type === 'checkbox' && this[i].name === this[i-1].name && this[i].checked ){
      this[i-1].disabled = true
    }
  }
  this.submit()
}
