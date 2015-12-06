(clear)

(deftemplate person "People in actuarial database"
    (slot age (default false))
    (slot name )
    (slot gender))
	
(deftemplate oldest-male (slot name) (slot age))

(assert (person (gender Male) (name "Mitt Romney") (age 61) ))
(assert (person (name "Bob Smith") (age 34) (gender Male)))
(assert (person (gender Male) (name "Tom Smith") (age 32) ))
(assert (person (name "Mary Smith") (age 34) (gender Female)))
(assert (person (gender Male) (name "Timothy Barnard") (age 54) ))
(assert (person (name "Missy D") (age 22) (gender Female)))
;(assert (person  (name "George Bush") (gender Male)))
;(assert (person (gender Female)))

(defglobal ?*count* = 0)
(defglobal ?*max* = 0 ?*max-name* = "")

(defrule oldest-male-rule
    (person (name ?n) (age ?a )(gender Male))
    =>
    ;(printout t "Age" ?a crlf)
    (if (> ?a ?*max*) then
        (bind ?*max* ?a)
        (bind ?*max-name* ?n)
    )
    (assert (older_male (name ?n) (age ?a))
)

 (defrule show-oldest-male
    ?f <- (older_male (name ?n) (age ?a))
    =>
    ; complete this rule which fires when other rules has finished.
     (printout t "New older person " ?n " age " ?a crlf)
)    
     
     
;(deffunction find-oldest-male ()
    ; student to complete this function
    ; involves asserts, runs and retracts
    ;(assert (oldest-male (age 0))
    
; )
   
(run)