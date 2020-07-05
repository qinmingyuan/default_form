HTMLInputElement.prototype.validForm = function() {
  let node = this.parentNode.parentNode
  node.classList.add('weui-cell_warn')
  node.insertAdjacentHTML('beforeend', '<i class="weui-icon-warn"></i>')
}

HTMLInputElement.prototype.clearValid = function() {
  let node = this.parentNode
  node.parentNode.classList.remove('weui-cell_warn')
  node.nextElementSibling.remove()
}
