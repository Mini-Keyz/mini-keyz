const initNavbarBackgroundScroll = () => {
  const navbar = document.getElementById("navbar");

  if (navbar) {
    document.addEventListener("scroll", () => {
      if (window.scrollY > 0) {
        navbar.classList.remove("bg-green-30");
        navbar.classList.add("shadow-sm", "bg-white");
      } else {
        navbar.classList.remove("shadow-sm", "bg-white");
        navbar.classList.add("bg-green-30");
      }
    });
  }
};

export { initNavbarBackgroundScroll };
