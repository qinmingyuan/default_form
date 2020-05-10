import { Controller } from 'stimulus'

// data-controller="datetime"
class DatetimeController extends Controller {

  connect() {
    console.log('Datetime Controller works!')
  }

  // data-action="datetime#default"
  default(event) {
    let el = event.currentTarget
    let date = new Date(el.value)



    this.append(el.name.replace('(date)', '(1i)'), date.getFullYear())
    this.append(el.name.replace('(date)', '(2i)'), date.getMonth() + 1)
    this.append(el.name.replace('(date)', '(3i)'), date.getDate())
  }

  append(name, value) {
    let input = this.element.elements.namedItem(name)
    if (input) {
      input.setAttribute('value', value)
    } else {
      input = document.createElement('input')
      input.setAttribute('type', 'hidden')
      input.setAttribute('name', name)
      input.setAttribute('value', value)

      this.element.appendChild(input)
    }
  }

}

application.register('datetime', DatetimeController)
