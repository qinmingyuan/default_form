import { Controller } from 'stimulus'

// data-controller="datetime"
class DefaultFormController extends Controller {

  defaultValid(input) {
    let label
    let locale = document.querySelector('html').lang
    let word
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

    for (let key in input.validity) {
      if (input.validity[key]) {
        word = i18ns[locale][key]
      }
    }

    if (input.labels.length > 0) {
      label = input.labels[0].innerText
    } else {
      label = input.dataset['label']
    }
    let text = word.replace('{label}', label)

    input.classList.add('is-danger')
    if (!input.parentNode.nextElementSibling) {
      let help = document.createElement('p')
      help.classList.add('help', 'is-danger')
      help.innerText = text
      input.parentNode.after(help)
    }
  }

  defaultClear(input) {
    input.classList.remove('is-danger')
    let help = input.parentNode.nextElementSibling
    if (help && help.classList.contains('help') && help.classList.contains('is-danger')) {
      help.remove()
    }
  }

  // data-action="blur->x#check"
  check(event) {
    event.currentTarget.checkValidity()
  }

  clear(event) {
    defaultClear(event.currentTarget)
  }

  // data-action="invalid->x#clear"
  input_invalid(event) {
    event.preventDefault()
    event.target.defaultFormValid()
  }

  // form[method="get"]
  // submit->xx
  filter(event) {
    event.preventDefault()
    let url = new URL(location)
    let form = new FormData(event.currentTarget)

    for (let el of form.entries()) {
      if (el[1].length > 0) {
        url.searchParams.set(el[0], el[1])
      }
    }

    Turbo.visit(url.href)
  }

}

application.register('default_form', DefaultFormController)
