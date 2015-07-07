; woodworking task with 30 parts and 100% wood
; Machines:
;   1 grinder
;   1 glazer
;   1 immersion-varnisher
;   1 planer
;   1 highspeed-saw
;   1 spray-varnisher
;   1 saw
; random seed: 473295

(define (problem wood-prob-s30)
  (:domain woodworking)
  (:objects
    grinder0 - grinder
    glazer0 - glazer
    immersion-varnisher0 - immersion-varnisher
    planer0 - planer
    highspeed-saw0 - highspeed-saw
    spray-varnisher0 - spray-varnisher
    saw0 - saw
    black red blue green mauve white - acolour
    walnut mahogany pine beech teak oak cherry - awood
    p0 p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p20 p21 p22 p23 p24 p25 p26 p27 p28 p29 - part
    b0 b1 b2 b3 b4 b5 b6 b7 b8 b9 - board
    s0 s1 s2 s3 s4 s5 s6 s7 s8 - aboardsize
  )
  (:init
    (grind-treatment-change varnished colourfragments)
    (grind-treatment-change glazed untreated)
    (grind-treatment-change untreated untreated)
    (grind-treatment-change colourfragments untreated)
    (is-smooth smooth)
    (is-smooth verysmooth)
    
    (boardsize-successor s0 s1)
    (boardsize-successor s1 s2)
    (boardsize-successor s2 s3)
    (boardsize-successor s3 s4)
    (boardsize-successor s4 s5)
    (boardsize-successor s5 s6)
    (boardsize-successor s6 s7)
    (boardsize-successor s7 s8)
    (has-colour glazer0 blue)
    (has-colour glazer0 natural)
    (has-colour glazer0 mauve)
    (has-colour glazer0 black)
    (has-colour glazer0 green)
    (has-colour glazer0 white)
    (has-colour glazer0 red)
    (has-colour immersion-varnisher0 blue)
    (has-colour immersion-varnisher0 natural)
    (has-colour immersion-varnisher0 mauve)
    (has-colour immersion-varnisher0 green)
    (has-colour immersion-varnisher0 black)
    (has-colour immersion-varnisher0 white)
    (has-colour immersion-varnisher0 red)
    (empty highspeed-saw0)
    (has-colour spray-varnisher0 blue)
    (has-colour spray-varnisher0 natural)
    (has-colour spray-varnisher0 mauve)
    (has-colour spray-varnisher0 green)
    (has-colour spray-varnisher0 black)
    (has-colour spray-varnisher0 white)
    (has-colour spray-varnisher0 red)
    (unused p0)
    (goalsize p0 small)
    
    
    
    
    (unused p1)
    (goalsize p1 small)
    
    
    
    
    (unused p2)
    (goalsize p2 medium)
    
    
    
    
    (unused p3)
    (goalsize p3 small)
    
    
    
    
    (unused p4)
    (goalsize p4 small)
    
    
    
    
    (available p5)
    (colour p5 mauve)
    (wood p5 teak)
    (surface-condition p5 rough)
    (treatment p5 varnished)
    (goalsize p5 medium)
    
    
    
    
    (available p6)
    (colour p6 mauve)
    (wood p6 cherry)
    (surface-condition p6 rough)
    (treatment p6 colourfragments)
    (goalsize p6 large)
    
    
    
    
    (unused p7)
    (goalsize p7 small)
    
    
    
    
    (unused p8)
    (goalsize p8 medium)
    
    
    
    
    (unused p9)
    (goalsize p9 medium)
    
    
    
    
    (unused p10)
    (goalsize p10 large)
    
    
    
    
    (unused p11)
    (goalsize p11 medium)
    
    
    
    
    (unused p12)
    (goalsize p12 small)
    
    
    
    
    (unused p13)
    (goalsize p13 large)
    
    
    
    
    (available p14)
    (colour p14 blue)
    (wood p14 pine)
    (surface-condition p14 smooth)
    (treatment p14 colourfragments)
    (goalsize p14 medium)
    
    
    
    
    (unused p15)
    (goalsize p15 medium)
    
    
    
    
    (unused p16)
    (goalsize p16 medium)
    
    
    
    
    (available p17)
    (colour p17 natural)
    (wood p17 oak)
    (surface-condition p17 verysmooth)
    (treatment p17 colourfragments)
    (goalsize p17 large)
    
    
    
    
    (unused p18)
    (goalsize p18 large)
    
    
    
    
    (unused p19)
    (goalsize p19 medium)
    
    
    
    
    (unused p20)
    (goalsize p20 large)
    
    
    
    
    (unused p21)
    (goalsize p21 medium)
    
    
    
    
    (unused p22)
    (goalsize p22 small)
    
    
    
    
    (unused p23)
    (goalsize p23 large)
    
    
    
    
    (unused p24)
    (goalsize p24 medium)
    
    
    
    
    (unused p25)
    (goalsize p25 medium)
    
    
    
    
    (unused p26)
    (goalsize p26 large)
    
    
    
    
    (unused p27)
    (goalsize p27 medium)
    
    
    
    
    (unused p28)
    (goalsize p28 medium)
    
    
    
    
    (unused p29)
    (goalsize p29 medium)
    
    
    
    
    (boardsize b0 s5)
    (wood b0 cherry)
    (surface-condition b0 smooth)
    (available b0)
    (boardsize b1 s2)
    (wood b1 mahogany)
    (surface-condition b1 rough)
    (available b1)
    (boardsize b2 s8)
    (wood b2 oak)
    (surface-condition b2 rough)
    (available b2)
    (boardsize b3 s2)
    (wood b3 oak)
    (surface-condition b3 rough)
    (available b3)
    (boardsize b4 s7)
    (wood b4 pine)
    (surface-condition b4 rough)
    (available b4)
    (boardsize b5 s2)
    (wood b5 pine)
    (surface-condition b5 rough)
    (available b5)
    (boardsize b6 s6)
    (wood b6 walnut)
    (surface-condition b6 smooth)
    (available b6)
    (boardsize b7 s7)
    (wood b7 teak)
    (surface-condition b7 smooth)
    (available b7)
    (boardsize b8 s5)
    (wood b8 teak)
    (surface-condition b8 smooth)
    (available b8)
    (boardsize b9 s7)
    (wood b9 beech)
    (surface-condition b9 rough)
    (available b9)
  )
  (:goal
    (and
      (available p0)
      (wood p0 pine)
      (surface-condition p0 smooth)
      (treatment p0 varnished)
      (available p1)
      (surface-condition p1 smooth)
      (treatment p1 glazed)
      (available p2)
      (colour p2 black)
      (treatment p2 glazed)
      (available p3)
      (colour p3 mauve)
      (wood p3 oak)
      (treatment p3 varnished)
      (available p4)
      (surface-condition p4 verysmooth)
      (treatment p4 varnished)
      (available p5)
      (colour p5 blue)
      (wood p5 teak)
      (surface-condition p5 verysmooth)
      (treatment p5 varnished)
      (available p6)
      (colour p6 white)
      (treatment p6 glazed)
      (available p7)
      (colour p7 red)
      (treatment p7 varnished)
      (available p8)
      (colour p8 mauve)
      (surface-condition p8 verysmooth)
      (treatment p8 varnished)
      (available p9)
      (colour p9 blue)
      (wood p9 oak)
      (surface-condition p9 smooth)
      (available p10)
      (wood p10 teak)
      (surface-condition p10 verysmooth)
      (available p11)
      (wood p11 cherry)
      (surface-condition p11 smooth)
      (available p12)
      (colour p12 green)
      (wood p12 oak)
      (treatment p12 glazed)
      (available p13)
      (colour p13 red)
      (wood p13 beech)
      (treatment p13 glazed)
      (available p14)
      (colour p14 green)
      (treatment p14 varnished)
      (available p15)
      (wood p15 pine)
      (surface-condition p15 smooth)
      (treatment p15 varnished)
      (available p16)
      (colour p16 natural)
      (surface-condition p16 smooth)
      (available p17)
      (colour p17 blue)
      (surface-condition p17 verysmooth)
      (available p18)
      (colour p18 white)
      (wood p18 oak)
      (treatment p18 varnished)
      (available p19)
      (colour p19 blue)
      (wood p19 teak)
      (surface-condition p19 smooth)
      (treatment p19 varnished)
      (available p20)
      (wood p20 walnut)
      (surface-condition p20 smooth)
      (available p21)
      (colour p21 natural)
      (wood p21 beech)
      (available p22)
      (colour p22 black)
      (wood p22 pine)
      (surface-condition p22 verysmooth)
      (treatment p22 varnished)
      (available p23)
      (colour p23 blue)
      (surface-condition p23 smooth)
      (treatment p23 varnished)
      (available p24)
      (colour p24 red)
      (surface-condition p24 verysmooth)
      (available p25)
      (surface-condition p25 verysmooth)
      (treatment p25 varnished)
      (available p26)
      (colour p26 mauve)
      (wood p26 teak)
      (treatment p26 glazed)
      (available p27)
      (surface-condition p27 verysmooth)
      (treatment p27 varnished)
      (available p28)
      (wood p28 beech)
      (treatment p28 glazed)
      (available p29)
      (colour p29 white)
      (wood p29 teak)
      (surface-condition p29 verysmooth)
    )
  )
  
)
