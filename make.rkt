#!/usr/bin/env racket
#lang scripty
#:dependencies '("base" "html-writing")
-----------------
#lang racket/base

(require racket/file)
(require "utils.rkt")

(if (directory-exists? "build")
    (delete-directory/files "build")
    (make-directory "build"))
(copy-directory/files "public" "build")

(require "about.rkt")
(write-string-to-file "build/about.html" (render:about))
