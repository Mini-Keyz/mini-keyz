import { Controller } from "stimulus";

export default class extends Controller {
  static get targets() {
    return ["cookiesElement"];
  }

  close() {
    this.cookiesElementTarget.remove();
  }
}
