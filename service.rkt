#lang racket/base

(require html-writing)
(require "common.rkt")

(define (render:service)
  (use-template "service.html.tmpl"
                "##NAVBAR##" (xexp->html (navbar "/service.html"))
                "##CONTACTS_ICON##" (xexp->html (contacts-icon))))

(provide render:service)
