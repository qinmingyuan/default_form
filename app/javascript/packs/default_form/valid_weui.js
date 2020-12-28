import { Controller } from 'stimulus'

class WeuiFormController extends Controller {

  validForm() {
    let node = this.parentNode.parentNode
    node.classList.add('weui-cell_warn')
    node.insertAdjacentHTML('beforeend', '<i class="weui-icon-warn"></i>')
  }

  clearValid () {
    let node = this.parentNode
    node.parentNode.classList.remove('weui-cell_warn')
    node.nextElementSibling.remove()
  }

}

application.register('weui_form', WeuiFormController)
