import { Controller } from "stimulus";

export default class extends Controller {
  static get targets() {
    return ["settings", "errorMessage", "inputField"];
  }

  connect() {
    // Get form color
    const formColor = this.settingsTarget.dataset.formColor;

    // Change input style if error
    if (this.hasErrorMessageTarget) {
      this.inputFieldTarget.classList.remove(`input-${formColor}`);
      this.inputFieldTarget.classList.add("input-error");
    }
  }
}
