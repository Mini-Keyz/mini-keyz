// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";

// Import Tailwind
import "stylesheets/application";

// Import dropdown set
import { initNavbarDropdown } from "../plugins/navbar_dropdown";
import { stylizeCheckbox } from "../plugins/form_checkbox";

Rails.start();
Turbolinks.start();
ActiveStorage.start();

document.addEventListener("turbolinks:load", () => {
  console.log("test");
  initNavbarDropdown();
  stylizeCheckbox({
    parentInputFieldId: "checkbox-delegated-maintenance",
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
  });
});
