$('form[method="get"]').submit(function(e){
  for (var i = 0; i < this.elements.length; i++) {
    if ( this[i].value.length === 0 ) {
      this[i].disabled = true;
    }

    if ( this[i].name === 'commit' ) {
      this[i].disabled = true;
    }

    if ( this[i].name === 'utf8' ) {
      this[i].disabled = true;
    }
  }
});

document.querySelectorAll('textarea[data-valid], input[data-valid]').forEach(function(el) {
  el.addEventListener('blur', function(){ this.checkValidity() });
  el.addEventListener('input', function(){ this.defaultFormClear() });
  el.addEventListener('invalid', function(e){
    e.preventDefault();
    this.defaultFormValid()
  });
});
