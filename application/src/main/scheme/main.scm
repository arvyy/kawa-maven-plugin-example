(import (scheme write)
        (math normal-distribution))

(define (read-number)
  (define l (read-line))
  (cond
    ((string->number l) => (lambda (num) num))
    (else
      (begin
        (display "Not a valid number. Enter again:\n")
        (read-number)))))

(define mean 0)
(define std 0)
(define x 0)

(display "Enter mean:\n")
(set! mean (read-number))
(display "Enter standard deviation:\n")
(set! std (read-number))
(display "Enter X for cumulative probability:\n")
(set! x (read-number))
(newline)
(display "P(x < X) = ")
(display (cumulative-probability mean std x))
(newline)
