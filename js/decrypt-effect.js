/**
 * decrypt-effect.js
 * AdoQeT • Hacker Matrix Text Decrypt / Scramble Animation
 */

(function () {
  "use strict";

  const CYBER_CHARS = "!<>-_\\/[]{}—=+*^?#0101";

  class TextDecryptor {
    constructor(el) {
      this.el = el;
      this.originalHtml = el.innerHTML;
      this.isScrambling = false;
      this.timer = null;
    }

    decrypt(duration = 750) {
      if (this.isScrambling) return;
      this.isScrambling = true;

      const originalText = this.el.innerText;
      const lines = originalText.split("\n");
      let frame = 0;
      const totalFrames = Math.max(15, Math.round(duration / 30));

      this.el.classList.add("decrypting");

      this.timer = setInterval(() => {
        frame++;
        const progress = frame / totalFrames;

        const scrambledLines = lines.map((line) => {
          let output = "";
          for (let i = 0; i < line.length; i++) {
            const char = line[i];
            if (char === " ") {
              output += " ";
            } else if (i / line.length < progress) {
              output += char;
            } else {
              output += CYBER_CHARS[Math.floor(Math.random() * CYBER_CHARS.length)];
            }
          }
          return output;
        });

        this.el.innerHTML = scrambledLines.join("<br>");

        if (frame >= totalFrames) {
          clearInterval(this.timer);
          this.el.innerHTML = this.originalHtml;
          this.el.classList.remove("decrypting");
          this.isScrambling = false;
        }
      }, 30);
    }
  }

  function initDecrypt() {
    const targets = document.querySelectorAll("#header-content h1, #header-content p");
    if (!targets || targets.length === 0) return;

    const decryptors = [];

    targets.forEach((target) => {
      const dec = new TextDecryptor(target);
      decryptors.push(dec);

      // Hover olayında tekrar çözülme animasyonunu tetikle
      target.addEventListener("mouseenter", () => {
        dec.decrypt(650);
      });
    });

    // Sayfa açılışında intro animasyonu bittikten hemen sonra sırayla tetikle
    setTimeout(() => {
      decryptors.forEach((dec, idx) => {
        setTimeout(() => {
          dec.decrypt(800);
        }, idx * 180);
      });
    }, 1500);
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", initDecrypt);
  } else {
    initDecrypt();
  }
})();
