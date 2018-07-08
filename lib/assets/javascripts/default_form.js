function assignDefault(self_dom) {
  var date = new Date(self_dom.value)
  var _year = document.querySelector('[name="' + self_dom.name.replace('(date)', '(1i)') + '"]')
  var _month = document.querySelector('[name="' + self_dom.name.replace('(date)', '(2i)') + '"]')
  var _date = document.querySelector('[name="' + self_dom.name.replace('(date)', '(3i)') + '"]')
  _year.value = date.getFullYear()
  _month.value = date.getMonth() + 1
  _date.value = date.getDate()
}

HTMLFormElement.prototype.cleanSubmit = function(){
  for (var i = 0; i < this.elements.length; i++) {
    if ( this[i].value.length === 0 ) {
      this[i].disabled = true;
    }

    if ( this[i].name === 'utf8' ) {
      this[i].disabled = true;
    }

    if ( this[i].type === 'checkbox' && this[i].name === this[i-1].name && this[i].checked ){
      this[i-1].disabled = true;
    }
  }
  this.submit();
}