#lang racket/base

(require racket/string)
(require racket/list)
(require racket/file)
(require racket/path)

;;; Utility functions

;; Function to write a string to a file, creating the parent directory if needed
(define (write-string-to-file filepath content)
  (define dirpath (path-only (string->path filepath)))
  (make-directory* dirpath)
  (call-with-output-file filepath
    (lambda (out)
      (fprintf out "~a" content))
    #:exists 'replace))

(define (group-into-pairs lst)
  (define len (length lst))
  (if (odd? len)
      (error "The list must contain an even number of elements.")
      (let loop ([lst lst] [acc '()])
        (if (empty? lst)
            (reverse acc)
            (loop (cddr lst) (cons (list (first lst) (second lst)) acc))))))

;; (use-template "template.txt"
;;               "foo" "bar"
;;               "baz" "blah")
;; => string
(define (use-template template . params)
  (let ([content (file->string template)]
        [rules (group-into-pairs params)])
    (foldl (lambda (rule acc)
             (string-replace acc (first rule) (second rule)))
           content
           rules)))

(provide use-template write-string-to-file)


;;; Common elements

(define (navbar active)
  (let* ([entries '(("/index.html" "NJAI") ("/activity.html" "活动与策划") ("/service.html" "服务与支持") ("/about.html" "关于我们"))]
         [lis (map (lambda (entry)
                     (let ([href (first entry)]
                           [text (second entry)])
                       (if (string=? href active)
                           `(li (@ (class "active")) (a (@ (href ,href)) ,text))
                           `(li (a (@ (href ,href)) ,text)))))
                   entries)])
    `((nav (@ (id "nav") (style "position: absolute; top: 0; width: 100%;"))
           (ul (@ (class "links"))
               ,lis
               ;  (ul (@ (class "icons"))
               ;      (li (a (@ (href "#") (class "icon brands fa-github")) (span (@ (class "label")) "GitHub"))))
               )))))

(define (contacts-icon)
  '(section
    (h3 "联系方式")
    (ul (@ (class "icons alt"))
        (li (a (@ (href "http://weixin.qq.com/r/0xxgZYLEe0oHKMYGb0lX") (class "icon brands alt fa-weixin")) (span (@ (class "label")) "Wechat")))
        (li (a (@ (href "https://500px.com.cn/n/m/tribe/1201bd676e3b4e5e95b6335dcebf91ef") (class "icon brands alt fa-500px")) (span (@ (class "label")) "500px")))
        (li (a (@ (href "https://space.bilibili.com/1714334678") (class "icon brands alt fa-bilibili")) (span (@ (class "label")) "Bilibili")))
        (li (a (@ (href "mailto:njaiyyds@163.com") (class "icon solid fa-envelope")) (span (@ (class "label")) "Email")))
        (li (a (@ (href "#") (class "icon solid fa-shop")) (span (@ (class "label")) "Email")))
        (li (a (@ (href "https://www.xiaohongshu.com/user/profile/6494520a000000000f0078df")) "xhs")))))


(define (styled-article date title content url)
  `(article (@ (class "post"))
    (header (@ (class "major"))
      (span (@ (class "date")) ,date)
      (h1 ,(if (string=? url "") title `(a (@ (href ,url)) ,title))))
    ,content))

(define (styled-article-nodate title content url)
  `(article (@ (class "post"))
    (header (@ (class "major"))
      (h1 ,(if (string=? url "") title `(a (@ (href ,url)) ,title))))
    ,content))

(provide navbar contacts-icon styled-article styled-article-nodate)
