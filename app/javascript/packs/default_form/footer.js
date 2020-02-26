document.querySelectorAll('textarea[data-valid], input[data-valid]').forEach(function(el) {
  el.addEventListener('blur', function() { this.checkValidity() })
  el.addEventListener('input', function() { this.defaultFormClear() })
  el.addEventListener('invalid', function(e) {
    e.preventDefault()
    this.defaultFormValid()
  })
})
