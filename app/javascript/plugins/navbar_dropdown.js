const initNavbarDropdown = () => {
  const navbarDropdown = document.getElementById("navbar-dropdown");
  const navbarDropdownItemsList = document.getElementById(
    "navbar-dropdown-items-list"
  );
  const navbarDropdownItems = document.querySelectorAll(
    ".navbar-dropdown-item"
  );

  if (navbarDropdown) {
    // Add event listeners on dropdown items to close dropdown when clicked
    navbarDropdownItems.forEach((navbarDropdownItem) => {
      navbarDropdownItem.addEventListener("click", () => {
        navbarDropdownItemsList.classList.toggle("hidden");
      });
    });

    // Reveal the menu
    navbarDropdown.addEventListener("click", () => {
      navbarDropdownItemsList.classList.toggle("hidden");
    });
  }
};

export { initNavbarDropdown };
