(define (problem att-logistics-a) (:domain att-logistics)
  (:objects package1 package2 package3 package4 
	    package5 package6 package7 package8
	    pgh-truck bos-truck la-truck airplane1 airplane2
	    bos-po pgh-po la-po bos-airport pgh-airport la-airport
	    pgh bos la)
  (:init  (OBJ package1)		; statis predicates
          (OBJ package2)
          (OBJ package3)
          (OBJ package4)
          (OBJ package5)
          (OBJ package6)
          (OBJ package7)
          (OBJ package8)
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
          (at package2 pgh-po)
          (at package3 pgh-po)
          (at package4 pgh-po)
          (at package5 bos-po)
          (at package6 bos-po)
          (at package7 bos-po)
          (at package8 la-po)
          (at airplane1 pgh-airport)
          (at airplane2 pgh-airport)
          (at bos-truck bos-po)
          (at pgh-truck pgh-po)
          (at la-truck la-po))
  (:goal (AND (at package1 bos-po)
	      (at package2 bos-airport)
	      (at package3 la-po)
	      (at package4 la-airport)
	      (at package5 pgh-po)
	      (at package6 pgh-airport)
	      (at package7 pgh-po)
	      (at package8 pgh-po)))
  (:length (:serial 11) (:parallel 11)) 
  )

