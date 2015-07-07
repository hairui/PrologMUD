(define (problem p6b)

  (:domain logistics)
  (:objects package6 package5 package4 package3 package2 package1 city4 city3 city2 city1 truck4 truck3 truck2 truck1 plane2 plane1 city4_1 city3_1 city2_1 city1_1 city4_2 city3_2 city2_2 city1_2)
  (:init 
    (obj package6)
    (obj package5)
    (obj package4)
    (obj package3)
    (obj package2)
    (obj package1)
    (city city4)
    (city city3)
    (city city2)
    (city city1)
    (truck truck4)
    (truck truck3)
    (truck truck2)
    (truck truck1)
    (airplane plane1)
    (airplane plane2)
    (location city4_1)
    (location city3_1)
    (location city2_1)
    (location city1_1)
    (location city4_2)
    (location city3_2)
    (location city2_2)
    (location city1_2)
    (airport city4_2)
    (airport city3_2)
    (airport city2_2)
    (airport city1_2)
    (in_city city4_2 city4)
    (in_city city4_1 city4)
    (in_city city3_2 city3)
    (in_city city3_1 city3)
    (in_city city2_2 city2)
    (in_city city2_1 city2)
    (in_city city1_2 city1)
    (in_city city1_1 city1)
    (at plane2 city4_2)
    (at plane1 city4_2)
    (at truck4 city4_1)
    (at truck3 city3_1)
    (at truck2 city2_1)
    (at truck1 city1_1)
    (at package6 city3_1)
    (at package5 city4_2)
    (at package4 city1_1)
    (at package3 city1_1)
    (at package2 city1_2)
    (at package1 city2_1)
    (prev_autstate_1_2)
    (prev_autstate_2_2)
    (prev_autstate_3_2)
  )
  (:goal (and
    (and
      (aut_in_final_1)
      (aut_in_final_2))
    (aut_in_final_3))))