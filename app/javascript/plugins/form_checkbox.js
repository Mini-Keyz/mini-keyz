const stylizeCheckbox = (arg) => {
  const parentInputField = document.getElementById(arg.parentInputFieldId);

  if (parentInputField) {
    const childrenArray = Array.from(parentInputField.children);

    // Toggle value on input on click
    childrenArray.forEach((child) => {
      child.addEventListener("click", (event) => {
        // child is the clickable box for the user (ie the wrapping div for input + label )
        event.preventDefault();
        const inputElement = child.children[0];

        inputElement.checked = !inputElement.checked;
      });
    });

    // Toggle style on box on click
    parentInputField.addEventListener("click", (event) => {
      childrenArray.forEach((child) => {
        if (child.localName === "div") {
          const inputElement = child.children[0];

          if (inputElement.checked) {
            child.classList.remove(...arg.classToApplyNotChecked);
            child.classList.add(...arg.classToApplyChecked);
          } else {
            child.classList.remove(...arg.classToApplyChecked);
            child.classList.add(...arg.classToApplyNotChecked);
          }
        }
      });
    });
  }
};

export { stylizeCheckbox };
