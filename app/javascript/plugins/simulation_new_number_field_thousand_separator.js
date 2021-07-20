const initNumberFieldThousandSeparator = () => {
  const numberFieldsThousandSeparatorElements = document.querySelectorAll(
    ".number-field-thousand-separator"
  );

  if (numberFieldsThousandSeparatorElements) {
    console.log(numberFieldsThousandSeparatorElements);

    numberFieldsThousandSeparatorElements.forEach(
      (numberFieldsThousandSeparatorElement) => {
        numberFieldsThousandSeparatorElement.addEventListener(
          "keyup",
          (event) => {
            console.log("hey");
            console.log(event);
            console.log(event.currentTarget);
            // Retrieve value from input field
            let inputValue = event.currentTarget.value;
            console.log(inputValue);

            // Sanitize the value using RegEx by removing unnecessary characters such as spaces, underscores, dashes, and letters
            inputValue = inputValue.replace(/[\D\s\._\-]+/g, "");

            // Make sure the value is an integer
            inputValue = inputValue ? parseInt(inputValue, 10) : 0;

            // Add the thousand separator with the toLocaleString() function, then pass the sanitised value back to the input element.
            inputValue =
              inputValue === 0 ? "" : inputValue.toLocaleString("en-US");

            console.log(inputValue);
            console.log(inputValue.toLocaleString("fr-FR"));
          }
        );
      }
    );
  }
};

export { initNumberFieldThousandSeparator };
