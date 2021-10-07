import { Controller } from "stimulus";

export default class extends Controller {
  static get targets() {
    return ["flashElement"];
  }

  close() {
    this.flashElementTarget.remove();
  }
}
