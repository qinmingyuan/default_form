// depend on semantic-ui

HTMLInputElement.prototype.validForm = function() {
  var self = $(this)
  self.parent().addClass('error');
  self.parent().popup({
    position: 'right center',
    className: {
      popup: 'ui inverted popup'
    },
    content: 'Please check ' + this.name
  }).popup('show');
}

HTMLInputElement.prototype.clearValid = function() {
  var self = $(this)
  self.parent().removeClass('error');
  self.parent().popup('destroy');
}

HTMLInputElement.prototype.assignDefault = function(){
  var date = new Date(this.value)
  var _year = document.querySelector('[name="' + this.name.replace('(date)', '(1i)') + '"]')
  var _month = document.querySelector('[name="' + this.name.replace('(date)', '(2i)') + '"]')
  var _date = document.querySelector('[name="' + this.name.replace('(date)', '(3i)') + '"]')
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