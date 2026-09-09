import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "name", "price", "img", "destroyLink"]
  
  open(event) { 
    this.nameTarget.textContent = event.currentTarget.dataset.roomName
    this.priceTarget.textContent = event.currentTarget.dataset.roomPrice
    this.imgTarget.src = event.currentTarget.dataset.roomImg
    this.destroyLinkTarget.href =event.currentTarget.dataset.roomDeletePath
    this.modalTarget.classList.remove("hidden")
  }
  close() { 
    this.modalTarget.classList.add("hidden")
  }
}
