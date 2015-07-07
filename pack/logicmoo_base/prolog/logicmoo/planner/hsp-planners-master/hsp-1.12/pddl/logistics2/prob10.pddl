(define (problem att-logistics2_5) (:domain att-logistics)
  (:objects package1 pgh-truck bos-truck la-truck airplane1 airplane2
	    bos-po pgh-po la-po bos-airport pgh-airport la-airport
	    pgh bos la)
  (:init  (OBJ package1)		; statis predicates
          (TRUCK pgh-truck)
          (TRUCK bos-truck)
          (TRUCK la-truck)
          (AIRPLANE airplane1)
          (AIRPLANE airplane2)
          (LOCATION bos-po)
          (LOCATION la-po)
          (LOCATION pgh-po)
          (LOCATION bos-airport)
          (LOCATION la-airport)
          (LOCATION pgh-airport)
          (AIRPORT bos-airport)
          (AIRPORT pgh-airport)
          (AIRPORT la-airport)
          (CITY pgh)
          (CITY bos)
          (CITY la)
          (IN-CITY pgh-po pgh)
          (IN-CITY pgh-airport pgh)
          (IN-CITY bos-po bos)
          (IN-CITY bos-airport bos)
          (IN-CITY la-po la)
          (IN-CITY la-airport la)
          (at package1 pgh-po)    ;; dynamic predicates
          (at airplane1 pgh-airport)
          (at airplane2 pgh-airport)
          (at bos-truck bos-po)
          (at pgh-truck pgh-po)
          (at la-truck la-po))
  (:goal (AND (at package1 bos-po)))
  (:length (:serial 10) (:parallel 9))
  )
