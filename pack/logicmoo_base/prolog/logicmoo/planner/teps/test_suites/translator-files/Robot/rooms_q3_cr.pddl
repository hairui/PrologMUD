(define (domain rooms)
  (:predicates
    (at ?x0 ?x1)
    (connects ?x0 ?x1 ?x2)
    (opened ?x0)
    (closed ?x0)
    (door ?x0)
    (holding ?x0)
    (object ?x0)
    (handempty)
    (autstate_1_2)
    (autstate_1_4)
    (autstate_1_1)
    (autstate_2_2)
    (autstate_2_4)
    (autstate_2_1)
    (autstate_3_2)
    (autstate_3_4)
    (autstate_3_1)
    (autstate_4_2)
    (autstate_4_4)
    (autstate_4_1)
    (autstate_5_2)
    (autstate_5_4)
    (autstate_5_1)
    (autstate_6_2)
    (autstate_6_1)
    (autstate_7_2)
    (autstate_7_1)
  )
  (:action open
    :parameters (?x0)
    :precondition 
      (exists (?x1 ?x2)
        (and
          (door ?x0)
          (and
            (at robot ?x1)
            (and
              (connects ?x0 ?x1 ?x2)
              (closed ?x0)))))

    :effect
      (and
        (opened ?x0)
        (when
          (autstate_1_2)
          (autstate_1_4))
        (when
          (or
            (and
              (autstate_1_4)
              (and
                (closed d1)
                (not 
                  (= ?x0 d1))))
            (autstate_1_2))
          (autstate_1_1))
        (when
          (autstate_2_2)
          (autstate_2_4))
        (when
          (or
            (and
              (autstate_2_4)
              (and
                (closed d12)
                (not 
                  (= ?x0 d12))))
            (autstate_2_2))
          (autstate_2_1))
        (when
          (autstate_3_2)
          (autstate_3_4))
        (when
          (or
            (and
              (autstate_3_4)
              (and
                (closed d23)
                (not 
                  (= ?x0 d23))))
            (autstate_3_2))
          (autstate_3_1))
        (when
          (autstate_4_2)
          (autstate_4_4))
        (when
          (or
            (and
              (autstate_4_4)
              (and
                (closed d34)
                (not 
                  (= ?x0 d34))))
            (autstate_4_2))
          (autstate_4_1))
        (when
          (autstate_5_2)
          (autstate_5_4))
        (when
          (or
            (and
              (autstate_5_4)
              (and
                (closed d4)
                (not 
                  (= ?x0 d4))))
            (autstate_5_2))
          (autstate_5_1))
        (when
          (and
            (autstate_6_2)
            (at robot c1))
          (autstate_6_1))
        (when
          (and
            (autstate_7_2)
            (at obj2 r4))
          (autstate_7_1))
        (not 
          (closed ?x0))
        (when
          (and
            (not 
              (= ?x0 d1))
            (closed d1))
          (not 
            (autstate_1_2)))
        (when
          (not 
            (or
              (and
                (autstate_1_4)
                (and
                  (closed d1)
                  (not 
                    (= ?x0 d1))))
              (autstate_1_2)))
          (not 
            (autstate_1_1)))
        (when
          (and
            (not 
              (= ?x0 d12))
            (closed d12))
          (not 
            (autstate_2_2)))
        (when
          (not 
            (or
              (and
                (autstate_2_4)
                (and
                  (closed d12)
                  (not 
                    (= ?x0 d12))))
              (autstate_2_2)))
          (not 
            (autstate_2_1)))
        (when
          (and
            (not 
              (= ?x0 d23))
            (closed d23))
          (not 
            (autstate_3_2)))
        (when
          (not 
            (or
              (and
                (autstate_3_4)
                (and
                  (closed d23)
                  (not 
                    (= ?x0 d23))))
              (autstate_3_2)))
          (not 
            (autstate_3_1)))
        (when
          (and
            (not 
              (= ?x0 d34))
            (closed d34))
          (not 
            (autstate_4_2)))
        (when
          (not 
            (or
              (and
                (autstate_4_4)
                (and
                  (closed d34)
                  (not 
                    (= ?x0 d34))))
              (autstate_4_2)))
          (not 
            (autstate_4_1)))
        (when
          (and
            (not 
              (= ?x0 d4))
            (closed d4))
          (not 
            (autstate_5_2)))
        (when
          (not 
            (or
              (and
                (autstate_5_4)
                (and
                  (closed d4)
                  (not 
                    (= ?x0 d4))))
              (autstate_5_2)))
          (not 
            (autstate_5_1)))
        (when
          (not 
            (and
              (autstate_6_2)
              (at robot c1)))
          (not 
            (autstate_6_1)))
        (when
          (not 
            (and
              (autstate_7_2)
              (at obj2 r4)))
          (not 
            (autstate_7_1)))
      )
    )
  (:action close
    :parameters (?x0)
    :precondition 
      (exists (?x1 ?x2)
        (and
          (door ?x0)
          (and
            (at robot ?x1)
            (and
              (connects ?x0 ?x1 ?x2)
              (opened ?x0)))))

    :effect
      (and
        (closed ?x0)
        (when
          (autstate_1_2)
          (autstate_1_4))
        (when
          (or
            (and
              (autstate_1_4)
              (or
                (= ?x0 d1)
                (closed d1)))
            (autstate_1_2))
          (autstate_1_1))
        (when
          (autstate_2_2)
          (autstate_2_4))
        (when
          (or
            (and
              (autstate_2_4)
              (or
                (= ?x0 d12)
                (closed d12)))
            (autstate_2_2))
          (autstate_2_1))
        (when
          (autstate_3_2)
          (autstate_3_4))
        (when
          (or
            (and
              (autstate_3_4)
              (or
                (= ?x0 d23)
                (closed d23)))
            (autstate_3_2))
          (autstate_3_1))
        (when
          (autstate_4_2)
          (autstate_4_4))
        (when
          (or
            (and
              (autstate_4_4)
              (or
                (= ?x0 d34)
                (closed d34)))
            (autstate_4_2))
          (autstate_4_1))
        (when
          (autstate_5_2)
          (autstate_5_4))
        (when
          (or
            (and
              (autstate_5_4)
              (or
                (= ?x0 d4)
                (closed d4)))
            (autstate_5_2))
          (autstate_5_1))
        (when
          (and
            (autstate_6_2)
            (at robot c1))
          (autstate_6_1))
        (when
          (and
            (autstate_7_2)
            (at obj2 r4))
          (autstate_7_1))
        (not 
          (opened ?x0))
        (when
          (or
            (closed d1)
            (= ?x0 d1))
          (not 
            (autstate_1_2)))
        (when
          (not 
            (or
              (and
                (autstate_1_4)
                (or
                  (= ?x0 d1)
                  (closed d1)))
              (autstate_1_2)))
          (not 
            (autstate_1_1)))
        (when
          (or
            (closed d12)
            (= ?x0 d12))
          (not 
            (autstate_2_2)))
        (when
          (not 
            (or
              (and
                (autstate_2_4)
                (or
                  (= ?x0 d12)
                  (closed d12)))
              (autstate_2_2)))
          (not 
            (autstate_2_1)))
        (when
          (or
            (closed d23)
            (= ?x0 d23))
          (not 
            (autstate_3_2)))
        (when
          (not 
            (or
              (and
                (autstate_3_4)
                (or
                  (= ?x0 d23)
                  (closed d23)))
              (autstate_3_2)))
          (not 
            (autstate_3_1)))
        (when
          (or
            (closed d34)
            (= ?x0 d34))
          (not 
            (autstate_4_2)))
        (when
          (not 
            (or
              (and
                (autstate_4_4)
                (or
                  (= ?x0 d34)
                  (closed d34)))
              (autstate_4_2)))
          (not 
            (autstate_4_1)))
        (when
          (or
            (closed d4)
            (= ?x0 d4))
          (not 
            (autstate_5_2)))
        (when
          (not 
            (or
              (and
                (autstate_5_4)
                (or
                  (= ?x0 d4)
                  (closed d4)))
              (autstate_5_2)))
          (not 
            (autstate_5_1)))
        (when
          (not 
            (and
              (autstate_6_2)
              (at robot c1)))
          (not 
            (autstate_6_1)))
        (when
          (not 
            (and
              (autstate_7_2)
              (at obj2 r4)))
          (not 
            (autstate_7_1)))
      )
    )
  (:action grasp
    :parameters (?x0)
    :precondition 
      (exists (?x1)
        (and
          (object ?x0)
          (and
            (at robot ?x1)
            (and
              (at ?x0 ?x1)
              (handempty)))))

    :effect
      (and
        (holding ?x0)
        (when
          (autstate_1_2)
          (autstate_1_4))
        (when
          (or
            (and
              (autstate_1_4)
              (closed d1))
            (autstate_1_2))
          (autstate_1_1))
        (when
          (autstate_2_2)
          (autstate_2_4))
        (when
          (or
            (and
              (autstate_2_4)
              (closed d12))
            (autstate_2_2))
          (autstate_2_1))
        (when
          (autstate_3_2)
          (autstate_3_4))
        (when
          (or
            (and
              (autstate_3_4)
              (closed d23))
            (autstate_3_2))
          (autstate_3_1))
        (when
          (autstate_4_2)
          (autstate_4_4))
        (when
          (or
            (and
              (autstate_4_4)
              (closed d34))
            (autstate_4_2))
          (autstate_4_1))
        (when
          (autstate_5_2)
          (autstate_5_4))
        (when
          (or
            (and
              (autstate_5_4)
              (closed d4))
            (autstate_5_2))
          (autstate_5_1))
        (when
          (and
            (autstate_6_2)
            (at robot c1))
          (autstate_6_1))
        (when
          (and
            (autstate_7_2)
            (at obj2 r4))
          (autstate_7_1))
        (not 
          (handempty))
        (when
          (closed d1)
          (not 
            (autstate_1_2)))
        (when
          (not 
            (or
              (and
                (autstate_1_4)
                (closed d1))
              (autstate_1_2)))
          (not 
            (autstate_1_1)))
        (when
          (closed d12)
          (not 
            (autstate_2_2)))
        (when
          (not 
            (or
              (and
                (autstate_2_4)
                (closed d12))
              (autstate_2_2)))
          (not 
            (autstate_2_1)))
        (when
          (closed d23)
          (not 
            (autstate_3_2)))
        (when
          (not 
            (or
              (and
                (autstate_3_4)
                (closed d23))
              (autstate_3_2)))
          (not 
            (autstate_3_1)))
        (when
          (closed d34)
          (not 
            (autstate_4_2)))
        (when
          (not 
            (or
              (and
                (autstate_4_4)
                (closed d34))
              (autstate_4_2)))
          (not 
            (autstate_4_1)))
        (when
          (closed d4)
          (not 
            (autstate_5_2)))
        (when
          (not 
            (or
              (and
                (autstate_5_4)
                (closed d4))
              (autstate_5_2)))
          (not 
            (autstate_5_1)))
        (when
          (not 
            (and
              (autstate_6_2)
              (at robot c1)))
          (not 
            (autstate_6_1)))
        (when
          (not 
            (and
              (autstate_7_2)
              (at obj2 r4)))
          (not 
            (autstate_7_1)))
      )
    )
  (:action release
    :parameters (?x0)
    :precondition 
      (holding ?x0)
    :effect
      (and
        (handempty)
        (when
          (autstate_1_2)
          (autstate_1_4))
        (when
          (or
            (and
              (autstate_1_4)
              (closed d1))
            (autstate_1_2))
          (autstate_1_1))
        (when
          (autstate_2_2)
          (autstate_2_4))
        (when
          (or
            (and
              (autstate_2_4)
              (closed d12))
            (autstate_2_2))
          (autstate_2_1))
        (when
          (autstate_3_2)
          (autstate_3_4))
        (when
          (or
            (and
              (autstate_3_4)
              (closed d23))
            (autstate_3_2))
          (autstate_3_1))
        (when
          (autstate_4_2)
          (autstate_4_4))
        (when
          (or
            (and
              (autstate_4_4)
              (closed d34))
            (autstate_4_2))
          (autstate_4_1))
        (when
          (autstate_5_2)
          (autstate_5_4))
        (when
          (or
            (and
              (autstate_5_4)
              (closed d4))
            (autstate_5_2))
          (autstate_5_1))
        (when
          (and
            (autstate_6_2)
            (at robot c1))
          (autstate_6_1))
        (when
          (and
            (autstate_7_2)
            (at obj2 r4))
          (autstate_7_1))
        (not 
          (holding ?x0))
        (when
          (closed d1)
          (not 
            (autstate_1_2)))
        (when
          (not 
            (or
              (and
                (autstate_1_4)
                (closed d1))
              (autstate_1_2)))
          (not 
            (autstate_1_1)))
        (when
          (closed d12)
          (not 
            (autstate_2_2)))
        (when
          (not 
            (or
              (and
                (autstate_2_4)
                (closed d12))
              (autstate_2_2)))
          (not 
            (autstate_2_1)))
        (when
          (closed d23)
          (not 
            (autstate_3_2)))
        (when
          (not 
            (or
              (and
                (autstate_3_4)
                (closed d23))
              (autstate_3_2)))
          (not 
            (autstate_3_1)))
        (when
          (closed d34)
          (not 
            (autstate_4_2)))
        (when
          (not 
            (or
              (and
                (autstate_4_4)
                (closed d34))
              (autstate_4_2)))
          (not 
            (autstate_4_1)))
        (when
          (closed d4)
          (not 
            (autstate_5_2)))
        (when
          (not 
            (or
              (and
                (autstate_5_4)
                (closed d4))
              (autstate_5_2)))
          (not 
            (autstate_5_1)))
        (when
          (not 
            (and
              (autstate_6_2)
              (at robot c1)))
          (not 
            (autstate_6_1)))
        (when
          (not 
            (and
              (autstate_7_2)
              (at obj2 r4)))
          (not 
            (autstate_7_1)))
      )
    )
  (:action move
    :parameters (?x0 ?x1)
    :precondition 
      (exists (?x2)
        (and
          (at robot ?x0)
          (and
            (connects ?x2 ?x0 ?x1)
            (opened ?x2))))

    :effect
      (and
        (forall (?x2)
          (when
            (or
              (= ?x2 robot)
              (holding ?x2))
            (at ?x2 ?x1)))

        (when
          (autstate_1_2)
          (autstate_1_4))
        (when
          (or
            (and
              (autstate_1_4)
              (closed d1))
            (autstate_1_2))
          (autstate_1_1))
        (when
          (autstate_2_2)
          (autstate_2_4))
        (when
          (or
            (and
              (autstate_2_4)
              (closed d12))
            (autstate_2_2))
          (autstate_2_1))
        (when
          (autstate_3_2)
          (autstate_3_4))
        (when
          (or
            (and
              (autstate_3_4)
              (closed d23))
            (autstate_3_2))
          (autstate_3_1))
        (when
          (autstate_4_2)
          (autstate_4_4))
        (when
          (or
            (and
              (autstate_4_4)
              (closed d34))
            (autstate_4_2))
          (autstate_4_1))
        (when
          (autstate_5_2)
          (autstate_5_4))
        (when
          (or
            (and
              (autstate_5_4)
              (closed d4))
            (autstate_5_2))
          (autstate_5_1))
        (when
          (and
            (autstate_6_2)
            (or
              (= ?x1 c1)
              (and
                (at robot c1)
                (not 
                  (= ?x0 c1)))))
          (autstate_6_1))
        (when
          (and
            (autstate_7_2)
            (or
              (and
                (= ?x1 r4)
                (holding obj2))
              (and
                (at obj2 r4)
                (not 
                  (and
                    (= ?x0 r4)
                    (holding obj2))))))
          (autstate_7_1))
        (forall (?x2)
          (when
            (or
              (= ?x2 robot)
              (holding ?x2))
            (not 
              (at ?x2 ?x0))))

        (when
          (closed d1)
          (not 
            (autstate_1_2)))
        (when
          (not 
            (or
              (and
                (autstate_1_4)
                (closed d1))
              (autstate_1_2)))
          (not 
            (autstate_1_1)))
        (when
          (closed d12)
          (not 
            (autstate_2_2)))
        (when
          (not 
            (or
              (and
                (autstate_2_4)
                (closed d12))
              (autstate_2_2)))
          (not 
            (autstate_2_1)))
        (when
          (closed d23)
          (not 
            (autstate_3_2)))
        (when
          (not 
            (or
              (and
                (autstate_3_4)
                (closed d23))
              (autstate_3_2)))
          (not 
            (autstate_3_1)))
        (when
          (closed d34)
          (not 
            (autstate_4_2)))
        (when
          (not 
            (or
              (and
                (autstate_4_4)
                (closed d34))
              (autstate_4_2)))
          (not 
            (autstate_4_1)))
        (when
          (closed d4)
          (not 
            (autstate_5_2)))
        (when
          (not 
            (or
              (and
                (autstate_5_4)
                (closed d4))
              (autstate_5_2)))
          (not 
            (autstate_5_1)))
        (when
          (not 
            (and
              (autstate_6_2)
              (or
                (= ?x1 c1)
                (and
                  (at robot c1)
                  (not 
                    (= ?x0 c1))))))
          (not 
            (autstate_6_1)))
        (when
          (not 
            (and
              (autstate_7_2)
              (or
                (and
                  (= ?x1 r4)
                  (holding obj2))
                (and
                  (at obj2 r4)
                  (not 
                    (and
                      (= ?x0 r4)
                      (holding obj2)))))))
          (not 
            (autstate_7_1)))
      )
    )
)