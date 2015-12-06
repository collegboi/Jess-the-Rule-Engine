(clear)
(deftemplate newCar (slot make) (slot warranty)(slot price)(slot color (default black))
)
    
(deftemplate usedCar (slot make) (slot yearSale) (slot milleage) (slot price) (slot color (default black))
)

(deftemplate min-price-car (slot make) (slot price) (slot milleage))

(defglobal ?*counter* = 0)
;--------------------------------------------------------

(deffacts car-facts
    (min-price-car  (price 100000))
    (usedCar (make Toyota) (yearSale 2010) (milleage 45000)(price 40000))
    (usedCar (make Fiat) (yearSale 2013) (milleage 45000)(price 40000))
    (usedCar (make BMW) (yearSale 2010) (milleage 21000)(price 30000))
    (usedCar (make Ford) (yearSale 2014) (milleage 100000)(price 23000))
    (usedCar (make volkswagen) (yearSale 2014) (milleage 40000) (color silver) (price 34000))
    (newCar (make Skoda) (warranty 4)(price 12000))
    (newCar (make Ford) (warranty 5) (color red)(price 45000))
    (newCar (make BMW) (warranty 5) (color silver)(price 60000))
    (newCar (make Mercedes) (warranty 2)(price 25000))
)
;--------------------------------------------------------

(defrule cars-rule-1
    ?d <- (done)
    (newCar (make ~volkswagen) (color ?c) (color red|black) (make ?m) (warranty ?w)(price ?p))
    =>
    (printout t "Have a car: " ?m " color: " ?c " warranty: "?w crlf)
)
;-------------------------------------------------------------------------

(defrule cars-rule-2
    ?d <- (done2)
    (newCar (make ?m)(color ?c)(price ?p) (price ?x&:(< ?x 30000)))
    ;(usedCar (make ?m) (color ?c) (milleage ?m&:(< ?m 50000)))
    =>
    (printout t "Have a car: " ?m " color: " ?c " cost: "?p crlf)
)
;----------------------------------------------------------------------------

(defrule cars-rule-3
    (year ?y)
    (usedCar (make volkswagen) (yearSale ?x&:(= ?x ?y)))
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
    (usedCar (make ?m) (yearSale ?y))
    =>
    (printout t "Make: " ?m " Year: "?y crlf) 
)
;----------------------------------------------------------------------------
(defrule cars-rule-4
    ?d <- (done3)
    (or (and (usedCar (make ?m) (make ~volkswagen) (color ?c ) (milleage ?x&:(< ?x 50000)) (milleage ?x&:(> ?x 20000))))
    (and (make volkswagen) (yearSale ?v&:(< ?v 2012)) (price ?w&:(< ?w 10000))))
    =>
    (printout t "Have a car: " ?m " color: " ?c crlf)
)
;----------------------------------------------------------------------------

(defrule min-price-5
    ?d <- (done4)
    ?f <- (min-price-car (price ?p))
    (usedCar (price ?x&:(< ?x ?p)) (make ?v) (color ~red|black)(milleage ?w))
    =>
    (printout t "New min price is " ?x  " make: " ?v ", old price is " ?p crlf)
    (modify ?f (price ?x) (make ?v)(milleage ?w))
)

;-----------------------------------------------------------------------------
(deffunction question1 ()
    (assert (done))
    (run)
)

(deffunction question2 ()
    (assert (done2))
    (run)
)

(deffunction question3 ()
    (printout t "Input year: " crlf)
    (bind ?y (read))
    (assert (year ?y))
    (run)
)

(deffunction question4 ()
    (assert (done3))
    (run)
)

(deffunction question5 ()
    (assert (done4))
    (run)
)

(reset)
(run)