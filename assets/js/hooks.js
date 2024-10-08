const Hooks = {};

Hooks.Clipboard = {
  mounted() {
    const originalInnerHTML = this.el.innerHTML;
    const { content } = this.el.dataset;

    this.el.addEventListener("click", () => {
      navigator.clipboard.writeText(content);

      this.el.innerHTML = '<i class="fas fa-check"></i> Copied';

      setTimeout(() => {
        this.el.innerHTML = originalInnerHTML;
      }, 2000);
    });
  },
};

export default Hooks;
