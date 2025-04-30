# parsec-lisp

## Introduction
Collection of files used to generate [parsec.ro](https://parsec.ro) website.

## File descriptions
`build-site.el`: this file is used, in Emacs, to export the content from .org files to .html; derived from [System Crafters](https://systemcrafters.net/publishing-websites-with-org-mode/building-the-site/);
`parsec.css`, based on ox-tufte.css, part of [ox-tufte](https://github.com/ox-tufte/ox-tufte) Emacs packages, modified to fit my own needs.

## Prerequisites
- Emacs (tested with 29.4 and 30.1);
- [ox-tufte](https://github.com/ox-tufte/ox-tufte) (tested with 4.2.1).

## Usage
Each .org file from your current folder and subfolders (with the exception of 'draft' subfolder) will be exported to an .html file in the 'public' subfolder; uses .css file to make everything prettier. Evaluate 'build-site.el' (by typing 'M-x evaluate-buffer' while buid-site.el is opened in Emacs) to populate the 'public folder' or run `emacs -Q --script build-site.el` in terminal.
