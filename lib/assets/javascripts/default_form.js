function assignDefault(self_dom) {
  var date = new Date(self_dom.value)
  var _year = document.querySelector('[name="' + self_dom.name.replace('(date)', '(1i)') + '"]')
  var _month = document.querySelector('[name="' + self_dom.name.replace('(date)', '(2i)') + '"]')
  var _date = document.querySelector('[name="' + self_dom.name.replace('(date)', '(3i)') + '"]')
  _year.value = date.getFullYear()
  _month.value = date.getMonth() + 1
  _date.value = date.getDate()
}