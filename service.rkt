#lang racket/base

(require html-writing)
(require "common.rkt")

(define (render:service)
  (use-template "service.html.tmpl"
                "##NAVBAR##" (xexp->html (navbar "/service.html"))
                "##CONTENT##"
                (xexp->html
                 (list (styled-article-nodate "胶片冲洗"
                                              '((p "作这一首《无俗念》词的，乃南宋末年一位武学名家，有道之士。此人姓丘，名处机，道号长春子，名列全真七子之一，是全真教中出类拔萃的人物。《词品》评论此词道:「长春，世之所谓仙人也，而词之清拔如此」。这首词诵的似是梨花，其实词中真意却是赞誉一位身穿白衣的美貌少女，说她「浑似姑射真人，天姿灵秀，意气殊高洁」，又说她「浩气清英，仙才卓荦」，「不与群芳同列」。词中所颂这美女，乃是古墓派传人小龙女。她一生爱穿白衣，当真如风拂玉树，雪裹琼苞，兼之生性清冷，实当得起「冷浸溶溶月」的形容，以「无俗念」三字赠之，可说十分贴切。长春子丘处机和她在终南山上比邻而居，当年一见，便写下这首词来。"))
                                              "#")
                       (styled-article-nodate "NJAI放映室"
                                              '((p "这少女十八、九岁年纪，身穿淡黄衣衫，骑着一头青驴，正沿山道缓缓而上，心中默想:「也只有龙姊姊这样的人物，才配得上他。」这一个「他」字，指的自然是神鵰大侠杨过了。她也不拉缰绳，任由那青驴信步而行，一路上山。过了良久，她又低声吟道:「欢乐趣，离别苦，就中更有痴儿女。君应有语，渺万里层云，千山暮雪，只影向谁去?」")
                                                (img (@ (src "images/pic06.jpg") (style "max-width: 100%;"))))
                                              "#")))
                "##CONTACTS_ICON##" (xexp->html (contacts-icon))))

(provide render:service)
