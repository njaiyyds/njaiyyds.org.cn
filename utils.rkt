#lang racket/base

(require racket/string)
(require racket/list)
(require racket/file)
(require racket/path)

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
