import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['node']
  static values = {
    index: Number
  }

  // data-action="click->field#add"
  add(event) {
    let el = this.element.cloneNode(true)
    let label = el.querySelector('label')
    if (label) {
      label.remove()
    }
    let nextIndex = this.indexValue + Math.random()  // todo find an better implement
    el.setAttribute('data-field-index-value', nextIndex)
    el.querySelectorAll('input, select').forEach(input => {
      input.name = input.name.replace(`[${this.indexValue}]`, `[${nextIndex}]`)
      input.id = input.id.replace(`${this.indexValue}`, `${nextIndex}`)
      input.value = null
    })

    if (this.element.parentNode) {
      this.element.parentNode.insertBefore(el, this.element.nextSibling)
    }
  }

  remove() {
    this.element.remove()
  }

}
