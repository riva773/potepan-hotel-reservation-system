import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "name", "modal", "sumPrice", "checkIn", "checkOut", "attendance", "img", "destroyLink" ]
  
  open(event) { 
    this.nameTarget.textContent = event.currentTarget.dataset.reservationRoom
    this.sumPriceTarget.textContent = event.currentTarget.dataset.reservationSumPrice
    this.checkInTarget.textContent = event.currentTarget.dataset.reservationCheckIn
    this.checkOutTarget.textContent = event.currentTarget.dataset.reservationCheckOut
    this.attendanceTarget.textContent = event.currentTarget.dataset.reservationAttendance
    this.imgTarget.src = event.currentTarget.dataset.reservationImg
    this.destroyLinkTarget.href = event.currentTarget.dataset.reservationDeletePath
    this.modalTarget.classList.remove("hidden")
  }

  close() { 
    this.modalTarget.classList.add("hidden")
  }
}
