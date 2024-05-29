#lang racket/base

(require html-writing)
(require "common.rkt")

(define (render:index)
  (use-template "index.html.tmpl"
                "##FEATURED##"
                (xexp->html
                 (styled-article
                  "3648年4月1日"
                  "示例"
                  '((p "越女采莲秋水畔，窄袖轻罗，暗露双金钏。照影摘花花似面，芳心只共丝争乱。鸡尺溪头风浪晚，雾重烟轻，不见来时伴。隐隐歌声归棹远，离愁引着江南岸。")
                    (p "一阵轻柔婉转的歌声，飘在烟水蒙蒙的湖面上。歌声发自一艘小船之中，船里五个少女和歌嘻笑，荡舟采莲。她们唱的曲子是北宋大词人欧阳修所作的“蝶恋花”词，写的正是越女采莲的情景，虽只寥寥六十字，但季节、时辰、所在、景物以及越女的容貌、衣着、首饰、心情，无一不描绘得历历如见，下半阕更是写景中有叙事，叙事中夹抒情，自近而远，余意不尽。欧阳修在江南为官日久，吴山越水，柔情密意，尽皆融入长短句中。宋人不论达官贵人，或里巷小民，无不以唱词为乐，是以柳永新词一出，有井水处皆歌，而江南春岸折柳，秋湖采莲，随伴的往往便是欧词。"))
                  "#"))
                "##NAVBAR##" (xexp->html (navbar "/index.html"))
                "##CONTACTS_ICON##" (xexp->html (contacts-icon))))

(provide render:index)
