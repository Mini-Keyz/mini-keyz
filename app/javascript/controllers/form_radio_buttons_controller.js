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
    "border-blue-200",
    "outline-none",
    "ring-1",
    "ring-blue-400",
    "border-transparent",
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
    "border-red-200",
    "outline-none",
    "ring-1",
    "ring-red-400",
    "border-transparent",
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
    "border-yellow-200",
    "outline-none",
    "ring-1",
    "ring-yellow-400",
    "border-transparent",
  ],
};

export default class extends Controller {
  static get targets() {
    return ["radioWrapper"];
  }

  connect() {
    this.style();
  }

  toggle(event) {
    console.log(event.target);
    const labelClicked = event.target;
    const inputClicked = labelClicked.previousElementSibling;
    console.log(inputClicked.checked);

    // Check or uncheck on click
    event.preventDefault();
    inputClicked.checked = !inputClicked.checked;
    console.log(inputClicked.checked);

    // Change radio button style depending on styling
    this.style();
  }

  style() {
    // Get each button parent div which has their input and label as children
    const radioParentsArray = Array.from(this.radioWrapperTarget.children);

    // Get the buttons color
    const btnColor = this.radioWrapperTarget.dataset.color;

    radioParentsArray.forEach((parent) => {
      if (parent.children[0].checked) {
        console.log("I am checked");
        parent.classList.remove(...eval(btnColor).classToApplyNotChecked);
        parent.classList.add(...eval(btnColor).classToApplyChecked);
      } else {
        console.log("I am not checked");
        parent.classList.remove(...eval(btnColor).classToApplyChecked);
        parent.classList.add(...eval(btnColor).classToApplyNotChecked);
      }
    });
  }
}
