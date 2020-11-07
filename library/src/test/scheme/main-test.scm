(import (scheme base)
        (srfi 64)
        (math normal-distribution))

(test-begin "Math normal distribution")

;; on test end exit with non-zero status if there were failures
(let* ((runner (test-runner-current))
       (callback (test-runner-on-final runner)))
  (test-runner-on-final!
    runner
    (lambda (r)
      (callback r)
      (exit (= 0 (test-runner-fail-count r))))))

(test-assert (= 0.5 (cumulative-probability 0 1 0)))

(test-end)
