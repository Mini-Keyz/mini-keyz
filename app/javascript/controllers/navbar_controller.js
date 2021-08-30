import { Controller } from "stimulus";

export default class extends Controller {
  static get targets() {
    return ["navbarElement"];
  }

  scrollDown() {
    console.log("scroll");
    if (window.scrollY > 0) {
      this.navbarElementTarget.classList.remove("bg-green-30");
      this.navbarElementTarget.classList.add("shadow-sm", "bg-white");
    } else {
      this.navbarElementTarget.classList.remove("shadow-sm", "bg-white");
      this.navbarElementTarget.classList.add("bg-green-30");
    }
  }
}
