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
        (li (a (@ (href "#") (class "icon brands alt fa-twitter")) (span (@ (class "label")) "Twitter")))
        (li (a (@ (href "#") (class "icon brands alt fa-facebook-f")) (span (@ (class "label")) "Facebook")))
        (li (a (@ (href "#") (class "icon brands alt fa-instagram")) (span (@ (class "label")) "Instagram")))
        (li (a (@ (href "#") (class "icon brands alt fa-github")) (span (@ (class "label")) "GitHub"))))))

(provide navbar contacts-icon)
