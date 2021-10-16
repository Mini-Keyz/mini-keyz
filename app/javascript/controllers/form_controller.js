import { Controller } from "stimulus";

export default class extends Controller {
  static get targets() {
    return ["formWrapper", "errorMessage"];
  }

  connect() {
    this.styleErrors();
  }

  hasError(inputWrapper) {
    return inputWrapper.find((element) => {
      return element.classList.contains("error_explanation");
    });
  }

  styleErrors() {
    // Get form color
    const formColor = this.formWrapperTarget.dataset.formColor;

    // Change input style if error
    const formFields = Array.from(this.formWrapperTarget.children);
    formFields.forEach((formField) => {
      const inputWrapper = Array.from(formField.children);

      const hasError = this.hasError(inputWrapper);
      console.log(hasError);

      const inputParentField = inputWrapper.filter((element) => {
        // Has to loop again because of form_for generating <div class="form_with_errors">...</div> around our label and input fields
        const children = Array.from(element.children);
        const inputChildrenFields = children.filter((child) => {
          return child.tagName === "INPUT";
        });
        return inputChildrenFields.length;
      });

      if (inputParentField.length === 0) return;

      const inputFields = inputParentField[0].children;
      const isInputTypingField = inputFields.length === 1;

      if (hasError && isInputTypingField) {
        inputFields[0].classList.remove(`input-${formColor}`);
        inputFields[0].classList.add("input-error");
      }
    });
  }
}
