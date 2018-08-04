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

$('.ui.radio.checkbox').checkbox();