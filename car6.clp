(clear)



(deftemplate car (slot make) (slot price) (slot year (default 2011)))

(defglobal ?*v* = volkswagen)

(deffacts car-facts
	(car (make volkswagen) (price 5000)(year 2011))
	(car (make volkswagen) (price 6000))
    (car (make toyota) (price 3000) (year 2011))
    (car (make fiat) (price 2000) (year 2000) )
    (car (make skoda) (price 5000))
    (car (make ford) (price 8000) (year 2010))
    (car (make ford) (price 12000))
	(car (make poop) (price 1000))
)
	


(defrule cars-from-year-rule-1
	(year ?y)
    (car (make ?m) (make ~volkswagen) (year ?x&:(= ?x ?y)))
    =>
    (printout t "Have a " ?m " car for price " ?y crlf) 	
)	

 (defrule cars-from-year-rule-0
     (initial-fact)
     =>
     (printout t "Input year: " crlf)
     (bind ?y (read))
     (assert (year ?y)))

(reset)     
(run)   