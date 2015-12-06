;----------------------- Init --------------------------------------
;
;(defrule year-rule
;    (initial-fact)
;     =>
;    (printout t "What is the weather today?: ie Rain, Dry" crlf)
;   (bind ?today (read))
    
;    (printout t "What is the rainfull today?: ie Low, High, Medium" crlf)
;    (bind ?rain (read))
    
;    (printout t "To what degree do you believe the rainfall is low? Enter a numeric certainty between 0 and 1.0 inclusive." crlf)
    (bind ?rainfull (read))
  
;    (printout t "What is the temperature today?: ie Cold, Warm, Hot" crlf)
;    (bind ?temp (read))
     
;    (printout t "To what degree do you believe the temperature is cold? Enter a numeric certainty between 0 and 1.0 inclusive." crlf)
;    (bind ?degree (read))
    
;    (assert (weather (weatherToday ?today) (rainfullDeg ?rainfull) (temperature ?temp) (tempDegree ?degree)))
;    (assert (weather (weatherToday ?today)))
;    (run)
;)