(define (slice start size stride array)
  (if (<= size 0)
      '() ; nothing is left
      (cons
       (ref array start) ; the first element
       (slice (+ start stride) (- size 1) stride array)))) ; rest elements

(define (gslice start sizes strides array)
  (if (<= (car sizes) 0)
      '() ; nothing is left
      (if (or (null? (cdr strides)) (null? (cdr sizes)))
	  (slice start (car sizes) (car strides) array) ; the first slice
	  (append ; rest slices
	   (gslice start (cdr sizes) (cdr strides) array) ; the first general slice
	   (gslice ; rest general slices
	    (+ start (car strides))
	    (cons (- (car sizes) 1) (cdr sizes))
	    strides
	    array)))))