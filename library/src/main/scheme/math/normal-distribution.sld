(define-library 
  (math normal-distribution)
  (import (scheme base)
          (class org.apache.commons.math3.distribution NormalDistribution))
  (export cumulative-probability)
  
  (begin
    (define (cumulative-probability mean ::double deviation ::double x ::double) ::double
      (define n (NormalDistribution mean deviation))
      (n:cumulativeProbability x))))
