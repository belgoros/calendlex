const Hooks = {};
Hooks.Flash = {
  mounted() {
    this.initFlash();
  },
  updated() {
    this.initFlash();
  },

  initFlash() {
    const flash = this.el.querySelector(".flash");

    if (flash) {
      setTimeout(() => {
        this.pushEvent("lv:clear-flash");
      }, 2000);
    }
  },
};

Hooks.Clipboard = {
  mounted() {
    const originalInnerHTML = this.el.innerHTML;
    const { content } = this.el.dataset;

    this.el.addEventListener("click", () => {
      navigator.clipboard.writeText(content);

      svg =
        '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="size-6">' +
        '<path fill-rule="evenodd" d="M19.916 4.626a.75.75 0 0 1 .208 1.04l-9 13.5a.75.75 0 0 1-1.154.114l-6-6a.75.75 0 0 1 1.06-1.06l5.353 5.353 8.493-12.74a.75.75 0 0 1 1.04-.207Z" clip-rule="evenodd" />' +
        "</svg>Copied";

      this.el.innerHTML = svg;
      setTimeout(() => {
        this.el.innerHTML = originalInnerHTML;
      }, 2000);
    });
  },
};

export default Hooks;
