const initFlashFadingOut = () => {
  const flashToFadeOut = document.getElementById("flash");

  if (flashToFadeOut) {
    let opacity = 0;
    let intervalID = 0;

    const fadeout = () => {
      setInterval(hide, 150);
      console.log("Executed");
    };

    const hide = () => {
      opacity = Number(
        window.getComputedStyle(flashToFadeOut).getPropertyValue("opacity")
      );

      if (opacity > 0) {
        opacity -= 0.05;
        flashToFadeOut.style.opacity = opacity;
      } else if (opacity === 0) {
        flashToFadeOut.remove();
      } else {
        clearInterval(intervalID);
      }
    };

    setTimeout(() => {
      fadeout();
    }, 2000);
  }
};

export { initFlashFadingOut };
