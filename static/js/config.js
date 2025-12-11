export let baseURL = "http://localhost:5000";
export let backupBaseUrl = "https://api.volt-physics.com";

// إعدادات Netlify
if (process.env.NODE_ENV === "production") {
  baseURL = process.env.REACT_APP_API_URL || "https://api.volt-physics.com";
}

// إعدادات خاصة بـ Netlify
export const netlifyConfig = {
  siteUrl: process.env.REACT_APP_SITE_URL || "https://volt-physics.netlify.app",
  functionsUrl: "/.netlify/functions",
  identityUrl: "/.netlify/identity"
};

export const dateOptions = {
  weekday: "long",
  year: "numeric",
  month: "short",
  day: "numeric",
};

export const config = {
  baseURL,
  dateOptions,
  backupBaseUrl,
};
export default config;