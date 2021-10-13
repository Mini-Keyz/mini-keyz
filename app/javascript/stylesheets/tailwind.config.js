module.exports = {
  purge: [
    "./app/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
  ],
  darkMode: "media", // or 'false' or 'media' or 'class'
  theme: {
    extend: {
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
