#lang racket/base

(require html-writing)
(require "common.rkt")

(define (render:activity)
  (use-template "activity.html.tmpl"
                "##NAVBAR##" (xexp->html (navbar "/activity.html"))
                "##CONTACTS_ICON##" (xexp->html (contacts-icon))))

(provide render:activity)
