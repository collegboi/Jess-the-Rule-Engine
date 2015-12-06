;------------------------------------------------------------------

;/* FORECAST: AN APPLICATION OF CERTAINTY FACTORS 
;control cf
;control ‘threshold 0.01’

;Rule: 1
;if today is rain
;then tomorrow is rain {cf 0.5}

;Rule: 2
;if today is dry
;then tomorrow is dry {cf 0.5}

;Rule: 3
;if today is rain
;and rainfall is low
;then tomorrow is dry {cf 0.6}

;Rule: 4
;if today is rain
;and rainfall is low
;and temperature is cold then tomorrow is dry {cf 0.7}
;FORECAST: AN APPLICATION OF CERTAINTY FACTORS 81

;Rule: 5
;if today is dry
;and temperature is warm then tomorrow is rain {cf 0.65}

;Rule: 6
;if today is dry
;and temperature is warm
;and sky is overcast
;then tomorrow is rain {cf 0.55}
;seek tomorrow */


(clear)

(deftemplate weather (slot weatherToday)  (slot rainfullDeg) (slot temperature) (slot tempDegree) (slot sky)(slot rainAmount))

;----------------------- Function way ---------------------------------
;rule 1 & 2
(deffunction rule1-2()
    (printout t "What is the weather today?: ie Rain, Dry" crlf)
    (bind ?w (read))
    
    (if(= ?w rain) then
         (printout t "What is the rainfall today? ie High, Low, Medium: " crlf)
         (bind ?y (read))
         (assert (weather (weatherToday ?w) (rainAmount ?y)))
    else
        (assert (weather (weatherToday ?w)))
     ) 
    (run)
)

;3
(deffunction rule3()
     (printout t "What is the rainfall today? ie High, Low, Medium: " crlf)
     (bind ?y (read))
     
     (printout t "To what degree do you believe the rainfall is low? Enter a numeric certainty between 0 and 1.0 inclusive." crlf)
     (bind ?x (read))
        
     (assert(weather (weatherToday rain) (rainAmount ?y) (rainfullDeg ?x)))
     (run)
)

;rule 4
(deffunction rule4()
     (printout t "What is the temperator today? ie Cold, Warm: " crlf)
     (bind ?t (read))
     
     (printout t "To what degree do you believe the temperature is cold? Enter a numeric certainty between 0 and 1.0 inclusive." crlf)
     (bind ?x (read))
        
     (assert (weather (weatherToday rain) (rainAmount low) (temperature ?t) (tempDegree ?x)))
     (run)
)

     
;----------------------- Rules --------------------------------------

(defrule weather-rule-1
    (weather (weatherToday rain) (rainAmount ~nil)(temperature ~nil))
    =>
    (bind ?c (* 1.0 0.5))
    (printout t "Tomorrow is rain with certainty of: "?c crlf)
)

(defrule weather-rule-2
    (weather (weatherToday dry)(rainAmount ~nil)(temperature ~nil))
    =>
    (bind ?c (* 1.0 0.5))
    (printout t "Tomorrow is dry with certainty of: "?c crlf)
)

(defrule weather-rule-3
    (weather (weatherToday rain) (rainAmount low) (rainfullDeg ?x) (temperature nil))
    =>
    (bind ?min (min2 1.0 ?x))
    (bind ?res (* ?min 0.6))
    (printout t "Tomorrow is dry with certainty of: "?res crlf)
)

(defrule weather-rule-4
    (weather (weatherToday rain) (rainAmount low) (temperature cold) (tempDegree ?x))
    =>
    (bind ?min (min3 1.0 0.8 ?x))
    (bind ?res (* ?min 0.65))
    (printout t "Tomorrow is dry with certainty of: "?res crlf)
)

(defrule weather-rule-5
    (weather (weatherToday dry) (temperature warm) (tempDegree ?x))
    =>
    (bind ?min (min3 1.0 0.8 ?x))
    (bind ?res (* ?min 0.55))
    (printout t "Tomorrow is rain with certainty of: "?res crlf)
)

(defrule weather-rule-6
    (weather (weatherToday dry) (temperature warm) (sky overcast) (tempDegree ?x))
    =>
    (bind ?min (min3 1.0 0.8 ?x))
    (bind ?res (* ?min 0.7))
    (printout t "Tomorrow is rain with certainty of: "?res crlf)
)

;------------------Min Function --------------------------
(deffunction min2 (?a ?b)
    (if (< ?a ?b) then
        (return ?a)
    else
        (return ?b)
    )
)

(deffunction min3 ($?args)
    (bind ?minval (nth$ 1 ?args))
    (foreach ?n ?args
        (if (< ?n ?minval) then (bind ?minval ?n))
    )
    (return ?minval)
)
;---------------------------------------------------------
(reset)     
(run)   