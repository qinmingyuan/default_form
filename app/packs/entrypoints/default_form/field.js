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
    el.setAttribute('data-field-index-value', this.indexValue + 1)

    if (this.element.parentNode) {
      this.element.parentNode.insertBefore(el, this.element.nextSibling)
    }
  }

}

application.register('field', FieldController)
