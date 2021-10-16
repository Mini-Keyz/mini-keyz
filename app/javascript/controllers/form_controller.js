import { Controller } from "stimulus";
// import { blue, red, yellow } from "../plugins_variables/radio_style";

const blue = {
  classToApplyNotChecked: [
    "flex",
    "justify-center",
    "items-center",
    "bg-white",
    "rounded",
    "border-2",
    "border-blue-200",
  ],
  classToApplyChecked: [
    "flex",
    "justify-center",
    "items-center",
    "bg-blue-200",
    "rounded",
    "border-2",
    "border-blue-400",
  ],
};

export default class extends Controller {
  static get targets() {
    return ["formWrapper", "errorMessage"];
  }

  // Fields are the <div> containing title + label + input + error

  connect() {
    this.styleErrors();
    this.styleRadio();
  }

  hasError(inputWrapper) {
    return inputWrapper.find((element) => {
      return element.classList.contains("error_explanation");
    });
  }

  getFormColor() {
    return this.formWrapperTarget.dataset.formColor;
  }

  styleErrors() {
    // Get form color
    const formColor = this.getFormColor();

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

  styleRadio() {
    // Get form color
    const formColor = this.getFormColor();

    // Change radio button style
    const formFields = Array.from(this.formWrapperTarget.children); // are the <div> containing title + label + input + error

    formFields.forEach((formField) => {
      if (this.isRadioField(formField)) {
        const radioFieldArray = Array.from(formField.children);
        console.log(radioFieldArray);

        radioFieldArray.forEach((radioFieldHTMLElement) => {
          if (this.isRadioBtnsWrapper(radioFieldHTMLElement)) {
            console.log(radioFieldHTMLElement);
            const radioBtnsArray = Array.from(radioFieldHTMLElement.children);
            console.log(radioBtnsArray);

            console.log(blue);
            console.log(eval(blue));
            console.log(formColor);
            console.log(eval(formColor));

            radioBtnsArray.forEach((parent) => {
              if (parent.children[0].checked) {
                parent.classList.remove(
                  ...eval(formColor).classToApplyNotChecked
                );
                parent.classList.add(...eval(formColor).classToApplyChecked);
              } else {
                parent.classList.remove(...eval(formColor).classToApplyChecked);
                parent.classList.add(...eval(formColor).classToApplyNotChecked);
              }
            });
          }
        });
      }
    });
  }

  isRadioField(formField) {
    console.log(formField.dataset.inputType);
    return formField.dataset.inputType === "radio-field";
  }

  isRadioBtnsWrapper(radioFieldHTMLElement) {
    console.log(radioFieldHTMLElement.dataset.inputType);
    return radioFieldHTMLElement.dataset.inputType === "radio-btns-wrapper";
  }
}
