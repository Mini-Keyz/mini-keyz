const initProfitabilityDropdowns = () => {
  const profitabilityRows = document.getElementById("profitabilities-rows");

  if (profitabilityRows) {
    console.log(profitabilityRows);
    console.log(profitabilityRows.children);

    const profitabilityRowsElements = Array.from(
      profitabilityRows.children
    ).filter((child) => child.dataset.profitability);

    console.log(profitabilityRowsElements);

    profitabilityRowsElements.forEach((profitabilityRowElement) =>
      profitabilityRowElement.addEventListener("click", (event) => {
        console.log("clicked²");
        console.log(event.currentTarget);
      })
    );
  }
};

export { initProfitabilityDropdowns };
