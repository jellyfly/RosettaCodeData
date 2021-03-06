#lang racket
(require racket/draw)

(define-syntax ⊕ (syntax-rules () [(_ id e) (set! id (+ id e))]))

(define (draw-point dc x y)
  (send dc draw-point x y))

(define (draw-circle dc x0 y0 r)
  (define f (- 1 r))
  (define ddf_x 1)
  (define ddf_y (* -2 r))
  (define x 0)
  (define y r)
  (draw-point dc    x0    (+ y0 r))
  (draw-point dc    x0    (- y0 r))
  (draw-point dc (+ x0 r)    y0)
  (draw-point dc (- x0 r)    y0)
  (let loop ()
    (when (< x y)
      (when (>= f 0)
        (⊕ y -1)
        (⊕ ddf_y 2)
        (⊕ f ddf_y))
      (⊕ x 1)
      (⊕ ddf_x 2)
      (⊕ f ddf_x)
      (draw-point dc (+ x0 x) (+ y0 y))
      (draw-point dc (- x0 x) (+ y0 y))
      (draw-point dc (+ x0 x) (- y0 y))
      (draw-point dc (- x0 x) (- y0 y))
      (draw-point dc (+ x0 y) (+ y0 x))
      (draw-point dc (- x0 y) (+ y0 x))
      (draw-point dc (+ x0 y) (- y0 x))
      (draw-point dc (- x0 y) (- y0 x))
      (loop))))

(define bm (make-object bitmap% 25 25))
(define dc (new bitmap-dc% [bitmap bm]))
(send dc set-smoothing 'unsmoothed)
(send dc set-pen "red" 1 'solid)
(draw-circle dc 12 12 12)
bm
