import { Controller } from "@hotwired/stimulus";

// leave for future consideration. Click hero cta to focus on first name field
class CtaFocusController {
  connect() {
    console.log("cta focus controller connected")
  }
  static targets = ["firstNameField"];

  heroCtaClick() {
    console.log("about to set focus on first name")
    this.firstNameFieldTarget.focus();
  }
}

export { CtaFocusController }
