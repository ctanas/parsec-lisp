;; Set the package installation directory so that packages aren't stored in the
;; ~/.emacs.d/elpa path, instead this is self-contained
(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Org-mode
(use-package org
  :ensure t
  :config
  ;; Allow code execution during export
  (setq org-export-babel-evaluate t)
  ;; Do not ask for confirmation before executing source blocks
  (setq org-confirm-babel-evaluate nil)

  ;; Load Babel languages
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (sqlite . t)))

  ;; Evaluate all Emacs Lisp source blocks when opening an Org buffer
  (add-hook 'org-mode-hook
            (lambda ()
              (org-babel-map-src-blocks (buffer-file-name)
                (when (string= "emacs-lisp" lang)
                  (org-babel-execute-src-block))))))

;; Export backends
(require 'ox-publish)
(use-package ox-tufte
  :ensure t
  :after org)
(use-package org-transclusion
  :ensure t
  :after org)

;; Loading all the variables needed in content
(load-file "func.el")

;; Customize the HTML output
(setq org-html-validation-link t              ;; Don't show validation link
      org-html-head-include-scripts nil       ;; Use our own scripts
      org-html-head-include-default-style nil ;; Use our own styles
      org-html-postamble t
      org-html-postamble-format '(("en" "<hr> <p class=\"footer\">©2009-2025 parsec.ro, CC BY &#8226; un site de <a href=\"https://tanaselia.ro\">Claudiu Tănăselia</a> &#8226; Generated with %c</p>"))
      )

;; Adding a hook for transcluded content
(add-hook 'org-mode-hook #'org-transclusion-mode)

;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "org-site:main"
             :recursive t
             :base-directory "../"
             :publishing-function 'org-tufte-publish-to-html
             :publishing-directory "../public"
             :with-author nil           ;; Don't include author name
             :with-creator t            ;; Include Emacs and Org versions in footer
             :with-toc nil              ;; Include a table of contents
             :section-numbers nil       ;; Don't include section numbers
             :html-preamble (with-temp-buffer
                            (insert-file-contents "../menu.html")
                            (buffer-string))
             :with-title nil
             :time-stamp-file nil

             :exclude "\\(?:^drafts/.*\\.org\\|^.packages/.*\\.org\\|^tools/.*\\.org\\)"
             :html-html5-fancy t
             :html-doctype "html5"
             )))

;; Generate the site output
(org-publish-all t)
