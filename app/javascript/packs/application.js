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

// Import plugins
import { initNavbarDropdown } from "../plugins/navbar_dropdown";
import { stylizeRadio } from "../plugins/form_radio";
import { initProfitabilityDropdowns } from "../plugins/simulation_show_profitability_dropdowns";

// Import plugins variables
import * as radioStyle from "../plugins_variables/radio_style";

Rails.start();
Turbolinks.start();
ActiveStorage.start();

document.addEventListener("turbolinks:load", () => {
  initNavbarDropdown();
  stylizeRadio({
    parentInputFieldId: "radio-house-property-management-cost",
    classToApplyNotChecked: radioStyle.radio_blue.classToApplyNotChecked,
    classToApplyChecked: radioStyle.radio_blue.classToApplyChecked,
  });
  stylizeRadio({
    parentInputFieldId: "radio-credit-loan-duration",
    classToApplyNotChecked: radioStyle.radio_red.classToApplyNotChecked,
    classToApplyChecked: radioStyle.radio_red.classToApplyChecked,
  });
  stylizeRadio({
    parentInputFieldId: "radio-fiscal-status",
    classToApplyNotChecked: radioStyle.radio_yellow.classToApplyNotChecked,
    classToApplyChecked: radioStyle.radio_yellow.classToApplyChecked,
  });
  stylizeRadio({
    parentInputFieldId: "radio-fiscal-regimen",
    classToApplyNotChecked: radioStyle.radio_yellow.classToApplyNotChecked,
    classToApplyChecked: radioStyle.radio_yellow.classToApplyChecked,
  });
  initProfitabilityDropdowns();
});
