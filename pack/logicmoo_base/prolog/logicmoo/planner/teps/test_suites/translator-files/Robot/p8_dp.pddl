(define (problem p8)

  (:domain rooms)
  (:objects c1 c4 r1 r2 r3 r4 d1 d12 d23 d34 d4 robot corridor obj1 obj2 obj3 obj4)
  (:init 
    (opened corridor)
    (connects d1 c1 r1)
    (connects d1 r1 c1)
    (connects d12 r1 r2)
    (connects d12 r2 r1)
    (connects d23 r2 r3)
    (connects d23 r3 r2)
    (connects d34 r3 r4)
    (connects d34 r4 r3)
    (connects d4 c4 r4)
    (connects d4 r4 c4)
    (connects corridor c1 c4)
    (connects corridor c4 c1)
    (door d1)
    (door d12)
    (door d23)
    (door d34)
    (door d4)
    (object obj1)
    (object obj2)
    (object obj3)
    (object obj4)
    (at obj1 r1)
    (at obj2 r2)
    (at obj3 r1)
    (at obj4 r1)
    (at robot c1)
    (handempty)
    (opened d1)
    (opened d12)
    (opened d23)
    (opened d34)
    (opened d4)
    (prev_autstate_1_2)
    (prev_autstate_2_2)
  )
  (:goal (and
    (autstate_1_1)
    (autstate_2_1))))