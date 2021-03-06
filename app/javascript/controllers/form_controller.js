import { Controller } from "stimulus";

export default class extends Controller {
  static get targets() {
    return ["formWrapper", "errorMessage"];
  }

  connect() {
    this.styleErrors();
  }

  hasError(formFieldArray) {
    return formFieldArray.find((element) => {
      return element.classList.contains("error_explanation");
    });
  }

  getFormColor() {
    const formSettings = document.getElementById("form-settings");
    return formSettings.dataset.formColor;
  }

  styleErrors() {
    // Get form color
    const formColor = this.getFormColor();

    // formFields are the <div> containing title + label + input + error
    const formFields = Array.from(this.formWrapperTarget.children);
    formFields.forEach((formField) => {
      const formFieldArray = Array.from(formField.children);

      const hasError = this.hasError(formFieldArray);

      const inputField = formFieldArray.filter((element) => {
        // Does not have to loop again because of form_for generating <div class="form_with_errors">...</div> around our label and input fields because we removed this div generation in our config/environment.rb
        return element.tagName === "INPUT";
      });

      if (inputField.length === 0) return;

      // Radio input fields have several input elements
      const isInputTypingField = inputField.length === 1;

      if (hasError && isInputTypingField) {
        inputField[0].classList.remove(`input-${formColor}`);
        inputField[0].classList.add("input-error");
      }
    });
  }
}
