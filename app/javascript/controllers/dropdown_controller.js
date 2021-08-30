import { Controller } from "stimulus"

export default class extends Controller {
  static get targets() {
    return ['dropdownMenu', 'dropdownButton']
  }

  initialize() {
    console.log("Initialized");
  }

  toggle() {
    console.log("Test");
    this.dropdownMenuTarget.classList.toggle("hidden")
  }

  hide(event) {
    if (event && this.dropdownButtonTarget.contains(event.target)) {
        return;
    }

    this.dropdownMenuTarget.classList.add("hidden")
  }
}