#!/usr/bin/env racket
#lang scripty                              ; \ script preamble
#:dependencies '("base" "html-writing") ; /
-----------------
#lang racket/base

(require html-writing)
(require "utils.rkt")

(define (namecard name school intro pic)
  `(div (@ (class "namecard"))
        (img (@ (src ,pic) (alt ,name)))
        (div (@ (class "intro"))
             (h2 ,intro)
             (h2 ,name)
             (h3 ,school))))

(define (render:about)
  (use-template "about.html.tml"
                "##NAMECARD##" (xexp->html `(,(namecard "王梓铨" "主席" "南京外国语学校" "/images/portrait/wzq.jpg")
                                             ,(namecard "栾兆宸" "公关助理" "南京外国语学校中加国际高中" "/images/portrait/lzc.jpg")
                                             ,(namecard "周熙皓" "外联专员" "南京市金陵中学" "/images/portrait/zxh.jpg")
                                             ,(namecard "赵子淇" "外联专员" "南京市中华中学" "/images/portrait/zzq.jpg")
                                             ,(namecard "顾正颢" "技术专员" "南京外国语学校" "/images/portrait/gzh.jpg")
                                             ,(namecard "严晓" "宣传专员" "南京市第一中学AP" "/images/portrait/yx.jpg")
                                             ,(namecard "权子淳" "宣传专员" "南京师范大学附属中学" "/images/portrait/qzc.jpg")
                                             ,(namecard "陈定一" "统计专员" "南京市第十三中学" "/images/portrait/cdy.jpg")
                                             ,(namecard "李乐怡" "统计专员" "南京外国语学校IC" "/images/portrait/lly.jpg")
                                             ,(namecard "张一弛" "顾问" "南京外国语学校IC" "/images/portrait/zyc.jpg")))))

(provide render:about)
