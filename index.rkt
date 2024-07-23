#lang racket/base

(require html-writing)
(require "common.rkt")

(define (render:index)
  (use-template "index.html.tmpl"
                "##FEATURED##"
                (xexp->html
                 (list
                  (styled-article-image "《你好，初次见面》南京中学生影像联盟摄影比赛"
                                        "/images/chucijianmian.jpg"
                                        "https://mp.weixin.qq.com/s?__biz=Mzg4ODk4MTEzOQ==&mid=2247483719&idx=1&sn=b804df1f14fadc27510c0aef45e46032&chksm=cff392bbf8841bad9191a708dd497457faf5ce4310aa624eb6ee854cbae88c08a371616410bf&token=699163028&lang=zh_CN#rd")
                  (styled-article-image "一起来用哈苏907X100C参加摄影接力挑战赛"
                                        "/images/907x.jpg"
                                        "https://www.bilibili.com/video/BV1XJ4m1b7MQ")
                  (styled-article-image "《你好，初次见面》摄影展"
                                        "/images/sheyinzhan.jpg"
                                        "https://mp.weixin.qq.com/s?__biz=Mzg4ODk4MTEzOQ==&mid=2247483846&idx=1&sn=461d73e278859934e8a3281bdc793abd&chksm=cff3923af8841b2c1dc1cb0ac573aef415616c91c7d97d27f4922be52e5ce2b273daf0e8937d&token=699163028&lang=zh_CN#rd")))
                "##NAVBAR##" (xexp->html (navbar "/index.html"))
                "##FOOTER##" (xexp->html (common-footer))))

(provide render:index)
