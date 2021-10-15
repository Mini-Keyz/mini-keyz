import { Controller } from "stimulus";

export default class extends Controller {
  static get targets() {
    return ["formWrapper", "errorMessage", "inputField"];
  }

  connect() {
    // Get form color
    const formColor = this.formWrapperTarget.dataset.formColor;

    // Change input style if error
    const formFields = Array.from(this.formWrapperTarget.children);
    formFields.forEach((formField) => {
      const inputWrapper = Array.from(formField.children);
      const hasError = inputWrapper.find((element) => {
        element.classList.contains("error_explanation");
      });
      const isTypingField = inputWrapper.filter((element) => {
        element.tagName == "INPUT";
      });
      console.log(isTypingField);
      if (hasError) {
      }
    });

    // Change input style if error
    if (this.hasErrorMessageTarget) {
      this.inputFieldTargets.classList.remove(`input-${formColor}`);
      this.inputFieldTargets.classList.add("input-error");
    }
  }
}
