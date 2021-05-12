const initProfitabilityDropdowns = () => {
  const profitabilityRows = document.getElementById("profitabilities-rows");

  if (profitabilityRows) {
    const childrenArray = Array.from(profitabilityRows.children);

    const grossProfitabilityDropdownHTML = "e";

    const grossProfitabilityElement = childrenArray.filter(
      (child) => child.dataset.profitability == "gross"
    );
    grossProfitabilityElement.addEventListener("click", () => {
      console.log("clicked²");
      const dropdownGrossProfitability = document.getElementById(
        "dropdown-gross-profitability"
      );
      if (dropdownGrossProfitability) {
        dropdownGrossProfitability.remove();
      } else {
        grossProfitabilityElement.insertAdjacentHTML(
          "beforeend",
          grossProfitabilityDropdownHTML
        );
      }
    });

    // const profitabilityRowsElements = childrenArray.filter(
    //   (child) => child.dataset.profitability
    // );
    // console.log(profitabilityRowsElements);
    // profitabilityRowsElements.forEach((element) =>
    //   element.addEventListener("click", () => {})
    // );
  }
};

export { initProfitabilityDropdowns };
