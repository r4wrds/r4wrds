document.addEventListener("DOMContentLoaded", () => {
  const selectors = [
    '#quarto-sidebar a[href="./index.html"]',
    '#quarto-sidebar a[href="index.html"]',
    '.quarto-page-breadcrumbs a[href="./index.html"]',
    '.quarto-page-breadcrumbs a[href="index.html"]',
  ];

  document.querySelectorAll(selectors.join(", ")).forEach((link) => {
    const chapterNumber = link.querySelector(".chapter-number");
    if (!chapterNumber) return;

    const possibleNbspNode = chapterNumber.nextSibling;
    chapterNumber.remove();

    if (
      possibleNbspNode &&
      possibleNbspNode.nodeType === Node.TEXT_NODE &&
      /^\s*\u00a0/.test(possibleNbspNode.textContent)
    ) {
      possibleNbspNode.remove();
    }
  });
});

