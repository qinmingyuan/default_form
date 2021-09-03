import { Controller } from '@hotwired/stimulus'

export default class extends Controller {

  // data-action="datetime#default"
  default(event) {
    let el = event.currentTarget
    let date = new Date(el.value)
    let form = el.form

    this.append(form, el.name.replace('(date)', '(1i)'), date.getFullYear())
    this.append(form, el.name.replace('(date)', '(2i)'), date.getMonth() + 1)
    this.append(form, el.name.replace('(date)', '(3i)'), date.getDate())
  }

  append(form, name, value) {
    let input = form.elements.namedItem(name)
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

