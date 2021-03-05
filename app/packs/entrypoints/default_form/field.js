import { Controller } from 'stimulus'

// data-controller="field"
class FieldController extends Controller {
  static targets = ['node']
  static values = {
    index: Number
  }

  connect() {
    console.debug('Field Controller connected!')
  }

  // data-action="click->field#add"
  add(event) {
    let el = this.element.cloneNode(true)
    let label = el.querySelector('label')
    if (label) {
      label.remove()
    }
    let nextIndex = this.indexValue + 1
    el.setAttribute('data-field-index-value', nextIndex)
    el.querySelectorAll('input').forEach(input => {
      input.name = input.name.replace(`[${this.indexValue}]`, `[${nextIndex}]`)
    })

    if (this.element.parentNode) {
      this.element.parentNode.insertBefore(el, this.element.nextSibling)
    }
  }

  remove() {
    this.element.remove()
  }

}

application.register('field', FieldController)
