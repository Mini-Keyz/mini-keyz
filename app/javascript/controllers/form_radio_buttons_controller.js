import { Controller } from "stimulus";

export default class extends Controller {
  static get targets() {
    return ["radioBtn"];
  }

  toggle() {
    console.log("Working");
    console.log(this.radioBtnTarget);
  }
}
