async function fetchDocumentCount() {
  const response = await fetch("../api/v1/search?q=objectType:mods AND state:published&rows=0&wt=json")
  if (!response.ok) {
    throw new Error(`HTTP error ${response.status}`);
  }
  const data = await response.json();
  return data?.response?.numFound ?? 0;
}

async function updateSearchPlaceholder () {
  const searchInput = document.getElementById("project-searchInput");
  if (!searchInput) {
    return;
  }
  const placeholderText = searchInput.placeholder;
  if (!/\d/.test(placeholderText)) {
    return;
  }
  try {
    const numFound = await fetchDocumentCount();
    const formattedNumFound = numFound.toLocaleString();
    searchInput.placeholder = placeholderText.replace(/\d[\d.,]*/, formattedNumFound);
  } catch(error) {
    console.error("Error while loading document count:", error);
    searchInput.placeholder = placeholderText.replace(/\d[\d.,]*/, '0');
  }
}

document.addEventListener('DOMContentLoaded', updateSearchPlaceholder);
