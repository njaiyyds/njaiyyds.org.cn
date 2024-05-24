#lang racket/base

(require html-writing)
(require "common.rkt")

(define (render:index)
  (use-template "index.html.tmpl"
                "##NAVBAR##" (xexp->html (navbar "/index.html"))
                "##CONTACTS_ICON##" (xexp->html (contacts-icon))))

(provide render:index)
