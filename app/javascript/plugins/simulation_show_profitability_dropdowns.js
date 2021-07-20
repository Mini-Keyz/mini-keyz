const initProfitabilityDropdowns = () => {
  const profitabilityRows = document.getElementById("profitabilities-rows");

  if (profitabilityRows) {
    const profitabilityRowsElements = Array.from(
      profitabilityRows.children
    ).filter((child) => child.dataset.profitabilityType);

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
