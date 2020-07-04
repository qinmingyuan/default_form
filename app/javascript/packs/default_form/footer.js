export function prepareFormValid() {
  document.querySelectorAll('textarea[data-valid], input[data-valid]').forEach(el => {
    el.addEventListener('blur', () => { this.checkValidity() })
    el.addEventListener('input', () => { this.defaultFormClear() })
    el.addEventListener('invalid', e => {
      e.preventDefault()
      this.defaultFormValid()
    })
  })
}
