[![Word Art](docs/images/wordArt.webp)](https://oi-wiki.org/)

# Welcome to **OI Wiki**！

[![Gitpod Ready-to-Code](https://img.shields.io/badge/Gitpod-Ready--to--Code-brightgreen?logo=gitpod&style=flat-square)](https://gitpod.io/#https://github.com/OI-wiki/OI-wiki)
[![Travis](https://img.shields.io/travis/OI-WIKI/OI-wiki.svg?style=flat-square)](https://travis-ci.org/OI-wiki/OI-wiki)
[![Uptime Robot Status](https://img.shields.io/uptimerobot/status/m781254113-3e3bac467c64fc99eafd383e.svg?style=flat-square)](https://status.oi-wiki.org/)
[![Telegram](https://img.shields.io/badge/OI--wiki-join%20Telegram%20chat-brightgreen.svg?style=flat-square)](https://t.me/OIwiki)
[![QQ](https://img.shields.io/badge/OI--wiki-join%20QQ%20group-brightgreen.svg?style=flat-square)](https://jq.qq.com/?_wv=1027&k=5EfkM6K)
[![GitHub watchers](https://img.shields.io/github/watchers/OI-Wiki/OI-Wiki.svg?style=social&label=Watch)](https://github.com/OI-wiki/OI-wiki)
[![GitHub stars](https://img.shields.io/github/stars/OI-Wiki/OI-Wiki.svg?style=social&label=Stars)](https://github.com/OI-wiki/OI-wiki)

* * *

## Content

Programming competitions have been around for many years. Its difficulty level is increasingly higher, and the content is getting increasingly more complicated. However, most of the online materials are scattered, which takes a lot of time to explore, and beginners often do not know how to learn relevant knowledge systematically.

In order to make it easier for friends who love programming competitions to get started, in July 2018, **OI Wiki** was migrated to GitHub. As the content of **OI Wiki** continues to improve, more and more friends are starting to join in.

**OI Wiki** is aimed to be a free, open and continuously updated knowledge integration website. You can find interesting and practical knowledge about **competitive programming** here. We have prepared the content including basic knowledge, common types of questions, problem-solving ideas, and common tools, etc., to help everyone learn programming competitions more quickly and deeply.

Right now, the content of **OI Wiki** still has many imperfections, the coverage of knowledge points is not comprehensive enough, and there are some pages whose quality needs to be modified. The **OI Wiki** team and the contributing friends are actively improving these content.

For the content to be improved above, please refer to [Issues](https://github.com/OI-wiki/OI-wiki/issues) and [Iteration Plan](https://github.com) of **OI Wiki** /OI-wiki/OI-wiki/labels/Iteration%20Plan%20%2F%20%E8%BF%AD%E4%BB%A3%E8%AE%A1%E5%88%92).

At the same time, **OI Wiki** originates from the community, advocating the **intellectual freedom**, and will never be commercialized in the future. We will always maintain its independent and freedom.

* * *

## Deploy

This project is currently deployed at [oi-wiki.org](https://oi-wiki.org) using [MkDocs](https://github.com/mkdocs/mkdocs).

We also maintain a list of mirror sites at [status.oi-wiki.org](https://status.oi-wiki.org). The contents and [oi-wiki.org](https://oi-wiki.org) are the same.

Of course, it can also be deployed locally. (**Requires Python 3**)

[Click to view the process of recorded with asciinema](https://asciinema.org/a/220681)

**If you encounter any problems, you can refer to [F.A.Q.](https://oi-wiki.org/intro/faq/) for more information.**

```bash
git clone https://github.com/OI-wiki/OI-wiki.git --depth=1

cd OI-wiki

# Install mkdocs
pip install mkdocs

# Use our customized theme
chmod +x ./scripts/install_theme.sh && ./scripts/install_theme.sh

# Two ways(choose one is enough):
# 1. Run a local server, visit http://127.0.0.1:8000 to view the effect
mkdocs serve -v

# 2. Get a static page under the site folder
mkdocs build -v

# To obtain the description of the mkdocs command line tool (explains the meaning of commands and parameters), please use
mkdocs --help
```

We are now rendering MathJax on the server side. If you want to achieve a similar effect, you may refer to [.travis.yml](https://github.com/OI-wiki/OI-wiki/blob/master/.travis.yml) for more details. ([Node.js](https://nodejs.org/en/download/) required)

### Mirror

```bash
# The content of the mirror repository on Gitee is the same as the GitHub repository
git clone https://gitee.com/OI-wiki/OI-wiki.git
```

### Offline version

You can use the content of the `gh-pages` branch

```bash
git clone https://gitee.com/OI-wiki/OI-wiki.git -b gh-pages
```

It may be more convenient to start an http server locally.

```bash
# If python3
python3 -m http.server
# If python2
python2 -m SimpleHTTPServer
# In some environments, you can’t find an executable file named python3/python2, so try running python to see if it works
```

### Docker

See [Docker deployment](https://oi-wiki.org/intro/docker-deploy/) for details.

* * *

## How to contribute to OI Wiki

We always welcome you to write content for **OI Wiki** and share what you have learned with you.

The specific way to contribute is in [How to Contribute](https://oi-wiki.org/intro/htc/) page.

* * *

## Copyright Licenses

<a rel="license" href="https://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License Agreement" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br />
Unless otherwise specified, except for the code part of the project, we all use <a rel="license" href="https://creativecommons.org/licenses/by-sa/4.0/deed.en">Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)</a> plus the additional [The Star And Thank Author License](https://github.com/zTrix/sata-license) as our licenses.

In other words, you may share in a reasonable manner during the use but you must sign, share in the same way without additional restrictions. And in no way should it suggest the licensor endorse you or your use.

And you need to star the GitHub repository.

And if you want to reference this GitHub repository, you can use the following bibtex:

```
@misc{oiwiki,
  author = {OI Wiki Team},
  title = {OI Wiki},
  year = {2016},
  publisher = {GitHub},
  journal = {GitHub Repository},
  howpublished = {\url{https://github.com/OI-wiki/i18n}},
}
```

* * *

## Thanks for contribution

This project is inspired by [CTF Wiki](https://ctf-wiki.github.io/ctf-wiki/), and has referenced multiple materials during the writing process. We also want to show our gratitude here.

Thank you very much to our [friends](https://github.com/OI-wiki/OI-wiki/graphs/contributors) who worked together to improve **OI Wiki** and [friends who donated to **OI Wiki** ](https://oi-wiki.org/intro/thanks/)!!!

<a href="https://github.com/OI-wiki/OI-wiki/graphs/contributors"><img src="https://opencollective.com/oi-wiki/contributors.svg?width=890&button=false" /></a>

And special thanks to the friends from [24OI](https://github.com/24OI) for their support!

<!-- <img src='https://i.loli.net/2018/12/07/5c0a6e4c31b30.png' alt='QVQNetWork' width=233>
Thanks to QVQNetwork for sponsored server -->

Thanks for the support from Peking University Computing Association and Hulu!

![](https://assets.pcmag.com/media/images/560767-hulu.png?width=333&height=245)
