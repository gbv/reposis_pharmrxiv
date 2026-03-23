// spam protection for mails
function replaceMaskedEmails() {
  document.querySelectorAll("span.madress").forEach(span => {
    const address = span.textContent.replace(" [at] ", "@");
    const link = document.createElement("a");
    link.href = `mailto:${address}`;
    link.textContent = address;
    span.replaceWith(link);
  });
}

function ignoreEmptyFieldsOnSubmit(event) {
  const form = event.currentTarget;
  const inputs = form.querySelectorAll('input');
  inputs.forEach(input => {
    if (!input.value) {
      input.dataset.nameBackup = input.name;
      input.removeAttribute('name');
    }
  });
  // Restore field names after the form is submitted
  // setTimeout ensures this runs after the submit event completes
  setTimeout(() => {
    inputs.forEach(input => {
      if (input.dataset.nameBackup) {
        input.name = input.dataset.nameBackup;
        delete input.dataset.nameBackup;
      }
    });
  }, 0);
}

function removeGenreOptions(values) {
  const select = document.querySelector("select#genre");
  if (!select) {
    return;
  }
  Array.from(select.options).forEach(option => {
    if (values.includes(option.value)) {
      option.remove();
    }
  });
}

function setupGenreObserver(values) {
  const observer = new MutationObserver(() => {
    removeGenreOptions(values);
  });
  observer.observe(document.body, {childList: true, subtree: true});
  return observer;
}

function initCookieBar() {
  if (window.jQuery && typeof $.cookieBar === "function") {
    $.cookieBar({
      fixed: true,
      message: "Auf den Seiten von Pharmrxiv werden zur Erhöhung des Bedienungskomforts Cookies verwendet. Mit der Nutzung dieser Seiten erklären Sie, dass Sie die rechtlichen Hinweise gelesen haben und akzeptieren.",
      acceptText: "Akzeptieren",
      policyButton: true,
      policyText: "Hinweise zum Datenschutz",
      policyURL: "https://www.tu-braunschweig.de/datenschutzerklaerung",
      expireDays: 1,
      zindex: 356,
      domain: "pharmrxiv.de",
      referrer: "pharmrxiv.de"
    });
  } else {
    console.warn("CookieBar plugin not found: skipping cookie bar initialization.");
  }
}

function initPage() {
  const genresToRemove = ["series", "journal"];
  setupGenreObserver(genresToRemove);
  replaceMaskedEmails();
  removeGenreOptions(genresToRemove);
  initCookieBar();
}

document.addEventListener("DOMContentLoaded", initPage);
