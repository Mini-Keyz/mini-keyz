const initProfitabilityDropdowns = () => {
  const profitabilityRows = document.getElementById("profitabilities-rows");

  if (profitabilityRows) {
    console.log(profitabilityRows);
    console.log(profitabilityRows.children);

    const profitabilityRowsElements = Array.from(
      profitabilityRows.children
    ).filter((child) => child.dataset.profitabilityType);

    console.log(profitabilityRowsElements);

    profitabilityRowsElements.forEach((profitabilityRowElement) =>
      profitabilityRowElement.addEventListener("click", (event) => {
        const profitabilityTextExplanation =
          event.currentTarget.nextElementSibling;
        profitabilityTextExplanation.classList.toggle("hidden");
      })
    );
  }
};

export { initProfitabilityDropdowns };
