module.exports = {
  purge: {
    // Files where we are purging unused TailwindCSS class names from
    content: [
      "./app/**/*.html.erb",
      "./app/helpers/**/*.rb",
      "./app/javascript/**/*.js",
    ],
    // TailwindCSS class names that we include in our final CSS file
    safelist: [
      "bg-green-100",
      "bg-blue-100",
      "bg-red-100",
      "bg-yellow-100",
      "border-green-200",
      "border-blue-200",
      "border-red-200",
      "border-yellow-200",
      "input-green",
      "input-blue",
      "input-red",
      "input-yellow",
      "w-36px",
      "w-88px",
      "w-112px",
      "w-200px",
      "w-1/4",
      "w-1/2",
      "w-3/4",
    ],
  },
  darkMode: "media", // or 'false' or 'media' or 'class'
  theme: {
    extend: {
      // Colors added to our available TailwindCSS class names => bg, border
      colors: {
        "green-frog": "#7cd7ac",
        "green-30": "#dfffef",
        "gray-30": "FAFAFA",
        "lime-500": "#84CC16",
      },
    },
  },
  variants: {
    extend: {
      visibility: ["hover", "group-hover"],
    },
  },
  plugins: [],
};
