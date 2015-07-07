;;;
;;; 1,4,9,3,11,6,8,5,10,2,7,12
;;; 
;;;
;;; Prolog-Planning-Library, using forward-iddfs.pl
;;; timeout (> 8:20minutes)
;;;
(define (problem m12-09)
   (:domain M12)
   (:objects v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12)
   (:init

        (pos1 v1)
        (pos2 v4)
        (pos3 v9)
        (pos4 v3)
        (pos5 v11)
        (pos6 v6)
        (pos7 v8)
        (pos8 v5)
        (pos9 v10)
        (pos10 v2)
        (pos11 v7)
        (pos12 v12)
   )

   (:goal (and 
       (pos1 v1)
       (pos2 v2)
       (pos3 v3)    
       (pos4 v4)    
       (pos5 v5)    
       (pos6 v6)   
       (pos7 v7)
       (pos8 v8)
       (pos9 v9)
       (pos10 v10)
       (pos11 v11)
       (pos12 v12)
       ))

   ;;; (:length (:serial 10) (:parallel 10))
)
