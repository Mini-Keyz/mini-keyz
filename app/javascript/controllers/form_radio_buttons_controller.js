import { Controller } from "stimulus";

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

const red = {
  classToApplyNotChecked: [
    "flex",
    "justify-center",
    "items-center",
    "bg-white",
    "rounded",
    "border-2",
    "border-red-200",
  ],
  classToApplyChecked: [
    "flex",
    "justify-center",
    "items-center",
    "bg-red-200",
    "rounded",
    "border-2",
    "border-red-400",
  ],
};

const yellow = {
  classToApplyNotChecked: [
    "flex",
    "justify-center",
    "items-center",
    "bg-white",
    "rounded",
    "border-2",
    "border-yellow-200",
  ],
  classToApplyChecked: [
    "flex",
    "justify-center",
    "items-center",
    "bg-yellow-200",
    "rounded",
    "border-2",
    "border-yellow-400",
  ],
};

export default class extends Controller {
  static get targets() {
    return ["formFieldWrapper", "radioWrapper"];
  }

  connect() {
    this.style();
    this.hasError();
  }

  toggle(event) {
    const labelClicked = event.target;
    console.log(labelClicked);
    const inputClicked = labelClicked.previousElementSibling;
    console.log(inputClicked);

    // Check or uncheck on click
    event.preventDefault();
    inputClicked.checked = !inputClicked.checked;

    // Change radio button style depending on styling
    this.style();
  }

  hasError() {
    const formField = Array.from(this.formFieldWrapperTarget);
    console.log(formField);
    // const inputWrapper = Array.from(formField.children);

    // const hasError = inputWrapper.find((element) => {
    //   return element.classList.contains("error_explanation");
    // });
  }

  style() {
    // Get each button parent div which has their input and label as children
    const radioParentsArray = Array.from(this.radioWrapperTarget.children);

    // Get the buttons color
    const btnColor = this.radioWrapperTarget.dataset.color;

    radioParentsArray.forEach((parent) => {
      if (parent.children[0].checked) {
        parent.classList.remove(...eval(btnColor).classToApplyNotChecked);
        parent.classList.add(...eval(btnColor).classToApplyChecked);
      } else {
        parent.classList.remove(...eval(btnColor).classToApplyChecked);
        parent.classList.add(...eval(btnColor).classToApplyNotChecked);
      }
    });
  }
}
