import { Controller } from "@hotwired/stimulus"
import { useClickOutside } from "stimulus-use"

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = ["content", "profile"]

  connect() {
    useClickOutside(this)
  }

  toggle() {
    if (this.contentTarget.classList.contains("hidden")) {
      this.open()
    } else {
      this.close()
    }
  }

  profileToggle() {
    if (this.profileTarget.classList.contains("hidden")) {
      this.openProfile()
    } else {
      this.closeProfile()
    }
  }

  open() {
    this.contentTarget.classList.remove("hidden")
    let main = document.querySelector("main")
    main.classList.add("blur")
    // document.body.classList.add('overflow-hidden')
  }

  openProfile() {
    this.profileTarget.classList.remove("hidden")
    let main = document.querySelector("main")
    main.classList.add("blur")
    // document.body.classList.add('overflow-hidden')
  }

  close() {
    this.contentTarget.classList.add("hidden")
    let main = document.querySelector("main")
    main.classList.remove("blur")
    // document.body.classList.remove('overflow-hidden')
  }

  closeProfile() {
    this.profileTarget.classList.add("hidden")
    let main = document.querySelector("main")
    main.classList.remove("blur")
    // document.body.classList.remove('overflow-hidden')
  }

  closeOnLargerScreen(event) {
    if (window.innerWidth > 768) {
      this.close()
      this.closeProfile()
    }
  }

  closeWithEscape(event) {
    event.preventDefault()
    if (event.key === "Escape") {
      this.close()
      this.closeProfile()
    }
  }

  clickOutside(event) {
    this.close()
    this.closeProfile()
  }
}