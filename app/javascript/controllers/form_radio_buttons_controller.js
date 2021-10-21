import { Controller } from "stimulus";
import { radio_style } from "../plugins_variables/radio_style";

export default class extends Controller {
  static get targets() {
    return ["radioWrapper"];
  }

  connect() {
    this.styleRadio();
  }

  getFormColor() {
    const formSettings = document.getElementById("form-settings");
    return formSettings.dataset.formColor;
  }

  hasError(formFieldArray) {
    return formFieldArray.find((element) => {
      return element.classList.contains("error_explanation");
    });
  }

  toggleRadio(event) {
    const labelClicked = event.target;
    const inputClicked = labelClicked.previousElementSibling;

    // Check or uncheck on click
    event.preventDefault();
    inputClicked.checked = !inputClicked.checked;

    // Change radio button style depending on styling
    this.styleRadio();
  }

  styleRadio() {
    // Get each button parent div which has their input and label as children
    const radioParentsArray = Array.from(this.radioWrapperTarget.children);
    const btnColor = this.getFormColor();

    radioParentsArray.forEach((parent) => {
      if (parent.children[0].checked) {
        parent.classList.remove(
          ...radio_style[btnColor].classToApplyNotChecked
        );
        parent.classList.add(...radio_style[btnColor].classToApplyChecked);
      } else {
        parent.classList.remove(...radio_style[btnColor].classToApplyChecked);
        parent.classList.add(...radio_style[btnColor].classToApplyNotChecked);
      }
    });
  }
}
