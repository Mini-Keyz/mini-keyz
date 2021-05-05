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
        console.log(inputElement);

        inputElement.checked = !inputElement.checked;
        console.log(inputElement.checked);
      });
    });

    // Toggle style on box on click
    parentInputField.addEventListener("click", (event) => {
      const labelElement = event.target;
      const inputElement = event.target.previousElementSibling; // As user click is on the label, previousElementSibling gets us the input html element
      console.log(event.target.previousElementSibling);
      console.log(event.target.previousElementSibling.checked);

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
