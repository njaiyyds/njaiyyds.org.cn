#lang racket/base

(require html-writing)
(require "common.rkt")

(define (namecard name intro school pic)
  `(div (@ (class "gallery-item"))
        (img (@ (src ,pic) (alt ,name)))
        (div (@ (class "intro"))
             (h2 ,intro)
             (h2 ,name)
             (h3 ,school))))

(define (render:about)
  (use-template "about.html.tmpl"
                "##NAVBAR##" (xexp->html (navbar "/about.html"))
                "##CONTACTS_ICON##" (xexp->html (contacts-icon))
                "##LICENSE##" (xexp->html (cr-footer))
                "##INITIAL##"
                (xexp->html
                 (styled-article-nodate
                  "我们的初心"
                  "南京中学生影像联盟初心是为广大的中学生摄影、摄像爱好者建立交流互助的平台。通过活动、比赛等提高中学生的审美价值观，陶治情操，为中学生生活增光添彩。南京中学生影像联盟不以利润为目的，更多的是用爱发电。影像是新时代的媒介，南京中学生影像联盟也正希望通过这种媒介，进一步帮助南京中学生表现自我，提升自我，永葆对影像的无限热爱。"
                  ""))
                "##NAMECARD##"
                (xexp->html
                 `(div (@ (class "gallery-container"))
                       ,(namecard "王梓铨" "主席" "南京外国语学校" "/images/portrait/wzq.jpg")
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
