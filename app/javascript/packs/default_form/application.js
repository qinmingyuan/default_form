HTMLElement.prototype.defaultFormValid = function() {
  let label
  let locale = document.querySelector('html').lang
  const i18ns = {
    zh: {
      badInput: '{label}格式不正确',
      customError: '{label}输入错误',
      patternMismatch: '非法的{label}',
      rangeOverflow: '{label}输入错误',
      rangeUnderflow: '{label}输入错误',
      stepMismatch: '{label}输入错误',
      tooLong: '{label}太长了',
      tooShort: '{label}太短了',
      typeMismatch: '{label}输入错误',
      valid: '{label}为非法值',
      valueMissing: '请输入{label}'
    },
    en: {
      badInput: 'Bad Input: {label}',
      customError: 'Custom Error: {label}',
      patternMismatch: 'Invalid Input: {label}',
      rangeOverflow: 'Range Over Flow: {label}',
      rangeUnderflow: 'Range Under Flow: {label}',
      stepMismatch: 'Step Mismatch',
      tooLong: '{label} is too long',
      tooShort: '{label} is Too Short',
      typeMismatch: '{label} Type Mismatch',
      valid: '{label} is not valid',
      valueMissing: 'Please enter: {label}'
    }
  }

  for (let key in this.validity) {
    if (this.validity[key]) {
      w = i18ns[locale][key]
    }
  }

  if (this.labels.length > 0) {
    label = this.labels[0].innerText
  } else {
    label = this.dataset['label']
  }

  text = w.replace('{label}', label)

  this.classList.add('is-danger')
  if (!this.parentNode.nextElementSibling) {
    let help = document.createElement('p')
    help.classList.add('help', 'is-danger')
    help.innerText = text
    this.parentNode.after(help)
  }
}

HTMLElement.prototype.defaultFormClear = function() {
  this.classList.remove('is-danger')
  let help = this.parentNode.nextElementSibling
  if (help && help.classList.contains('help') && help.classList.contains('is-danger')) {
    help.remove()
  }
}
