export function prepareFormValid() {
  document.querySelectorAll('textarea[data-valid], input[data-valid]').forEach(el => {
    el.addEventListener('blur', e => { e.target.checkValidity() })
    el.addEventListener('input', e => { e.target.defaultFormClear() })
    el.addEventListener('invalid', e => {
      e.preventDefault()
      e.target.defaultFormValid()
    })
  })
}
