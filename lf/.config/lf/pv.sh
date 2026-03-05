#!/bin/bash

case "$1" in
*.tar*) tar tf "$1" ;;
*.zip) unzip -l "$1" ;;
*.gz) gzip -cd "$1" | batcat --color always --style plain ;;
# *.rar) unrar l "$1" ;;
*.7z) 7z l "$1" ;;
*.pdf) pdftotext "$1" - ;;
*) batcat --color always --style plain "$1" ;;
esac
