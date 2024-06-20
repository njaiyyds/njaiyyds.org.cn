#lang racket/base

(require html-writing)
(require "common.rkt")

(define (render:service)
  (use-template "service.html.tmpl"
                "##NAVBAR##" (xexp->html (navbar "/service.html"))
                "##CONTENT##"
                (xexp->html
                 (list (styled-article-nodate "胶片冲洗"
                                              '((img (@ (src "/images/chongxi.jpg")
                                                        (style "max-width: 100%;"))))
                                              "#")
                       (styled-article-nodate "艺术微喷"
                                              '((img (@ (src "images/yishuweipen.jpg")
                                              (style "max-width: 100%;"))))
                                              "https://mp.weixin.qq.com/s?__biz=Mzg4ODk4MTEzOQ==&mid=2247484202&idx=1&sn=0a926ef5b5d6c5d0822658dc0187994b&chksm=cff390d6f88419c02778a9948671475df6785bdc0e24d41f6087da709afa90a0116839c7fc17&token=699163028&lang=zh_CN#rd")))
                "##FOOTER##" (xexp->html (common-footer))))

(provide render:service)
