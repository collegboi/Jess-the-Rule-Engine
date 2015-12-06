(clear)

(deftemplate person "Person in acturial database"
	(slot age (default false))
	(slot name)
	(slot gender))
	
(assert(person (name "Timothy") ( age 28) ( gender Male)))

(defglobal ?*count* = 0)
(defglobal ?*min* = 200 ?*min-name* = "")

(defrule youngest-rule-1
	(person (name ?n) (age ?a))
	=>
	(if (< ?a ?*min*() then
		(printout t "New youungest person: " ?n "age: " ?a " prev age was: " ?*m* crlf)
		(bind ?*min* ?a)
		(bind ?*min-name* ?n)))

(defrule count-males-rule
	(person (gender Male))
	=>
	(bind ?*count* (+ ?*count* 1)))
	
(deffunction show-male-count () 
	(printout t "Male Count is" ?*count* crlf))
	
(run)
(show-male-count)