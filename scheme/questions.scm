(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

; Some utility functions that you may find useful to implement

(define (zip pairs)
    (cons (map car pairs) (cons (map cadr pairs) nil))
)


;; Problem 15
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 15
  (define (helper n lst) 
      (if (eq? lst nil) nil (cons (cons n (cons (car lst) nil)) (helper (+ n 1) (cdr lst)))))
  (helper 0 s))
  ; END PROBLEM 15

;; Problem 16

;; Merge two lists LIST1 and LIST2 according to COMP and return
;; the merged lists.
(define (merge comp list1 list2)
  ; BEGIN PROBLEM 16
  (cond ((eq? list1 nil) list2)
        ((eq? list2 nil) list1)
        (else (if (comp (car list1) (car list2))
                  (cons (car list1) (merge comp (cdr list1) list2))
                  (cons (car list2) (merge comp list1 (cdr list2))))))
  )
  ; END PROBLEM 16


(merge < '(1 5 7 9) '(4 8 10))
; expect (1 4 5 7 8 9 10)
(merge > '(9 7 5 1) '(10 8 4 3))
; expect (10 9 8 7 5 4 3 1)

;; Problem 17

(define (nondecreaselist s)
    ; BEGIN PROBLEM 17
    (define (first pre s) (cond ((eq? s nil) nil)
                                 ((> pre (car s)) nil)
                                 (else (cons (car s) (first (car s) (cdr s))))
                            )
    )
    (define (rest pre s) (cond ((eq? s nil) nil)
                                 ((> pre (car s)) s)
                                 (else (rest (car s) (cdr s)))
                            )
    )
    (let ((lst_f (first (car s) s)) (lst_r (rest (car s) s))) 
         (if (eq? lst_r nil) (cons lst_f nil)
             (cons lst_f (nondecreaselist lst_r))
             ))
    
) 
    ; END PROBLEM 17

;; Problem EC
;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond ((atom? expr)
         ; BEGIN PROBLEM EC
         expr
         ; END PROBLEM EC
         )
        ((quoted? expr)
         ; BEGIN PROBLEM EC
         expr
         ; END PROBLEM EC
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM EC
           (cons form (cons (let-to-lambda params) (let-to-lambda body)))
           ; END PROBLEM EC
           ))
        ((let? expr)
         (let ((values (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM EC
           (let ((formals (car (zip values))) (args (cadr (zip values))))
                (cons (cons lambda (cons formals body)) args))
           ; END PROBLEM EC
           ))
        (else
         ; BEGIN PROBLEM EC
         (map let-to-lambda expr)
         ; END PROBLEM EC
         )))

