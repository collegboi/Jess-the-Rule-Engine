(clear)



(deftemplate car (slot make) (slot price) (slot year (default 2011)))

(defglobal ?*v* = volkswagen)
(defglobal ?*counter* = 0)

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
    (car (make volkswagen))
    =>
    (bind ?*counter* 1)
)	

(deffunction checkCar()
    (if(= ?*counter* 0) then
       (printout t "VW not Found" crlf) 
       (assert(check))
       (run)
    else 
        (printout t "VW Found" crlf)
    )
)
(defrule cars-from-year-rule-2
    ?c <- (check)
    (car (make ?m) (price ?p) (year ?y))
    =>
    (printout t "Make: " ?m " Price: " ?p " Year: "?y crlf) 
)

     
(reset)     
(run)
(checkCar())