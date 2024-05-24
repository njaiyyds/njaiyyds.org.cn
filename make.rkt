#!/usr/bin/env racket
#lang racket/base

(require racket/file)
(require "common.rkt")

(if (directory-exists? "build")
    (delete-directory/files "build")
    (void))
(copy-directory/files "public" "build")

(require "index.rkt")
(write-string-to-file "build/index.html" (render:index))

(require "about.rkt")
(write-string-to-file "build/about.html" (render:about))

(require "activity.rkt")
(write-string-to-file "build/activity.html" (render:activity))

(require "service.rkt")
(write-string-to-file "build/service.html" (render:service))
