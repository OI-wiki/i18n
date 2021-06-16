disqus:
pagetime:
title: OI Wiki

# Welcome to **OI Wiki** ！ [![GitHub watchers](https://img.shields.io/github/watchers/OI-wiki/OI-wiki.svg?style=social&label=Watch)](https://github.com/OI-wiki/OI-wiki)  [![GitHub stars](https://img.shields.io/github/stars/OI-wiki/OI-wiki.svg?style=social&label=Stars)](https://github.com/OI-wiki/OI-wiki) 

 [![Word Art](https://cdn.jsdelivr.net/npm/oicdn@0.0.1/wordArt.webp)](https://github.com/OI-wiki/OI-wiki) 

Olympiad in Informatics, or **OI**, entered China in 1984, and it is among five major high school academic competitions. Since 1989, a national training team for International Olympiad in Informatics, or IOI, will be selected each year.

International Collegiate Programming Contest, or **ICPC**, is held by ICPC Foundation, and is one of the most influential computing compeitions in colleges. There are two parts in ICPC -- Regionals and World Finals respectively. It is also known as ACM compeition since this organization sponsored it in the past.

 **OI Wiki** aims to be a free and lively updated site that integrates resources, in which readers can get interesting and useful knowledge about **competitive programming**. There are basic knowledge, frequently seen problems, way of solving problems, and useful tools to help everyone to learn quicker and deeper.

This project is inspired by [CTF Wiki](https://ctf-wiki.github.io/ctf-wiki/) and referenced a lot of materials. Thanks for all helps provided.

This project is hosted on [GitHub](https://github.com/OI-wiki/OI-wiki), and uses [Issues](https://github.com/OI-wiki/OI-wiki/issues) / [QQ](https://jq.qq.com/?_wv=1027&k=5EfkM6K) / [Telegram](https://t.me/OIwiki) to communicate.

Welcome joining our Telegram group at [@OIwiki](https://t.me/OIwiki) and QQ group at [ `588793226` ](https://jq.qq.com/?_wv=1027&k=5EfkM6K) ! 

**Note:** This is the English fork of the [main site](https://oi-wiki.org) which is actively updating. The initial translation work of this site is part of the [Open Source Promotion Plan](https://summer.iscas.ac.cn/) with OI Wiki a community in the project in 2020 and 2021. In 2020, [isdanni](https://github.com/isdanni), as a participant of [this project](https://github.com/OI-wiki/OI-wiki/wiki/Open-Source-Promotion-Plan---Summer-2020#6-%E7%BF%BB%E8%AF%91%E6%B4%BB%E5%8A%A8export) (Chinese link), made significant contribution to this project and translated about half of the site. **Special thanks for her work!** 

## Material color palette 

### Primary colors 

> `white` by default.

Click on the colors to change the primary color of the theme.

<div id="color-button">
<button data-md-color-primary="red">Red</button>
<button data-md-color-primary="pink">Pink</button>
<button data-md-color-primary="purple">Purple</button>
<button data-md-color-primary="deep-purple">Deep Purple</button>
<button data-md-color-primary="indigo">Indigo</button>
<button data-md-color-primary="blue">Blue</button>
<button data-md-color-primary="light-blue">Light Blue</button>
<button data-md-color-primary="cyan">Cyan</button>
<button data-md-color-primary="teal">Teal</button>
<button data-md-color-primary="green">Green</button>
<button data-md-color-primary="light-green">Light Green</button>
<button data-md-color-primary="lime">Lime</button>
<button data-md-color-primary="yellow">Yellow</button>
<button data-md-color-primary="amber">Amber</button>
<button data-md-color-primary="orange">Orange</button>
<button data-md-color-primary="deep-orange">Deep Orange</button>
<button data-md-color-primary="brown">Brown</button>
<button data-md-color-primary="grey">Grey</button>
<button data-md-color-primary="blue-grey">Blue Grey</button>
<button data-md-color-primary="white">White</button>
</div>

<script>
  var buttons = document.querySelectorAll("button[data-md-color-primary]");
  Array.prototype.forEach.call(buttons, function(button) {
    button.addEventListener("click", function() {
      document.body.dataset.mdColorPrimary = this.dataset.mdColorPrimary;
      localStorage.setItem("data-md-color-primary",this.dataset.mdColorPrimary);
    })
  })
</script>

### Accent colors 

> `red` by default

Click on the colors to change the accent color of the theme.

<div id="color-button">
<button data-md-color-accent="red">Red</button>
<button data-md-color-accent="pink">Pink</button>
<button data-md-color-accent="purple">Purple</button>
<button data-md-color-accent="deep-purple">Deep Purple</button>
<button data-md-color-accent="indigo">Indigo</button>
<button data-md-color-accent="blue">Blue</button>
<button data-md-color-accent="light-blue">Light Blue</button>
<button data-md-color-accent="cyan">Cyan</button>
<button data-md-color-accent="teal">Teal</button>
<button data-md-color-accent="green">Green</button>
<button data-md-color-accent="light-green">Light Green</button>
<button data-md-color-accent="lime">Lime</button>
<button data-md-color-accent="yellow">Yellow</button>
<button data-md-color-accent="amber">Amber</button>
<button data-md-color-accent="orange">Orange</button>
<button data-md-color-accent="deep-orange">Deep Orange</button>
</div>

<script>
  var buttons = document.querySelectorAll("button[data-md-color-accent]");
  Array.prototype.forEach.call(buttons, function(button) {
    button.addEventListener("click", function() {
      document.body.dataset.mdColorAccent = this.dataset.mdColorAccent;
      localStorage.setItem("data-md-color-accent",this.dataset.mdColorAccent);
    })
  })

  // #758
  document.getElementsByClassName('md-nav__title')[1].click()
</script>

<div align="center">
<a href="https://www.hulu.com/" target="_blank"><img height="40px" src="https://cdn.jsdelivr.net/npm/oicdn@0.0.1/hulu-black.png"></a>
<a href="https://www.netlify.com/" target="_blank" style="margin-left: 60px;"><img height="40px" src="https://cdn.jsdelivr.net/npm/oicdn@0.0.2/netlify.png"></a>
</div>
