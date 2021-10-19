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

  hasErrorForm() {
    return this.hasErrorMessageTarget;
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

  toggleRadio(event) {
    const labelClicked = event.target;
    console.log(labelClicked);

    if (this.hasErrorForm()) {
      // CHANGE HASFORMERROR to only take into consideration when THIS field has an error!!!
      console.log("hasErrorForm");
      const labelDivWithErrors = labelClicked.parentNode;
      console.log(labelDivWithErrors);

      const radioBtn = Array.from(labelDivWithErrors.parentNode.children);
      console.log(radioBtn);

      const inputDivWithErrors = radioBtn[0];
      console.log(inputDivWithErrors);

      const inputClicked = Array.from(inputDivWithErrors.children)[0];
      console.log(inputClicked);

      // Check or uncheck on click
      event.preventDefault();
      inputClicked.checked = !inputClicked.checked;

      // Change radio button style depending on styling
      this.styleRadio();

      return;
    }

    const inputClicked = labelClicked.previousElementSibling;
    console.log(inputClicked);

    // Check or uncheck on click
    event.preventDefault();
    inputClicked.checked = !inputClicked.checked;

    // Change radio button style depending on styling
    this.styleRadio();
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
        // THERE we should do it a bit differently if hasError() returns true

        // If there is an error, Rails generates a another level of DOM with <div class="field_with_errors">...</div>
        const hasErrorField = this.hasError(radioFieldArray);
        console.log(hasErrorField);

        // THIS works when this field has no errors
        radioFieldArray.forEach((radioFieldHTMLElement) => {
          if (this.isRadioBtnsWrapper(radioFieldHTMLElement)) {
            console.log(radioFieldHTMLElement);
            const radioBtnsArray = Array.from(radioFieldHTMLElement.children);
            console.log(radioBtnsArray);

            console.log(blue);
            console.log(eval(blue));
            console.log(formColor);
            console.log(eval(formColor));

            radioBtnsArray.forEach((radioBtn) => {
              console.log(radioBtn.children);
              console.log(radioBtn.children[0]);
              if (radioBtn.children[0].checked) {
                radioBtn.classList.remove(
                  ...eval(formColor).classToApplyNotChecked
                );
                radioBtn.classList.add(...eval(formColor).classToApplyChecked);
              } else {
                radioBtn.classList.remove(
                  ...eval(formColor).classToApplyChecked
                );
                radioBtn.classList.add(
                  ...eval(formColor).classToApplyNotChecked
                );
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
