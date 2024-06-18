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
                       (styled-article-nodate "NJAI放映室"
                                              '((p "这少女十八、九岁年纪，身穿淡黄衣衫，骑着一头青驴，正沿山道缓缓而上，心中默想:「也只有龙姊姊这样的人物，才配得上他。」这一个「他」字，指的自然是神鵰大侠杨过了。她也不拉缰绳，任由那青驴信步而行，一路上山。过了良久，她又低声吟道:「欢乐趣，离别苦，就中更有痴儿女。君应有语，渺万里层云，千山暮雪，只影向谁去?」")
                                                (img (@ (src "images/pic06.jpg") (style "max-width: 100%;"))))
                                              "#")))
                "##FOOTER##" (xexp->html (common-footer))))

(provide render:service)
