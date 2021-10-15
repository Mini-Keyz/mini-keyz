import { Controller } from "stimulus";

export default class extends Controller {
  static get targets() {
    return ["formWrapper", "errorMessage"];
  }

  connect() {
    this.styleErrors();
  }

  styleErrors() {
    // Get form color
    const formColor = this.formWrapperTarget.dataset.formColor;

    // Change input style if error
    const formFields = Array.from(this.formWrapperTarget.children);
    formFields.forEach((formField) => {
      const inputWrapper = Array.from(formField.children);
      console.log(inputWrapper);

      const hasError = inputWrapper.find((element) => {
        console.log(element.classList.contains("error_explanation"));
        return element.classList.contains("error_explanation");
      });
      console.log(hasError);

      const inputFields = inputWrapper.filter((element) => {
        console.log(element.tagName === "INPUT");
        return element.tagName === "INPUT";
      });
      console.log(inputFields);

      const isInputTypingField = inputFields.length === 1;
      console.log(isInputTypingField);

      if (hasError && isInputTypingField) {
        inputFields.classList.remove(`input-${formColor}`);
        inputFields.classList.add("input-error");
      }
    });
  }
}
