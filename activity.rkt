#lang racket/base

(require html-writing)
(require "common.rkt")

(define (render:activity)
  (use-template "activity.html.tmpl"
                "##NAVBAR##" (xexp->html (navbar "/activity.html"))
                "##FOOTER##" (xexp->html (common-footer))))

(provide render:activity)
