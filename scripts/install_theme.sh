#!/usr/bin/env bash

set -e

if [ ! -d "mkdocs-material" ] ; then
  git clone --depth=1 https://github.com/CamberLoid/OI-Wiki_mkdocs-material.git --branch i18n mkdocs-material
fi

sed -i "s/name: 'material'/name: null\n  custom_dir: 'mkdocs-material\/material'\n  static_templates:\n    - 404.html/g" mkdocs.yml
