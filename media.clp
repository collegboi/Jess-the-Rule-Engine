(clear)

(deftemplate enviorment "Enviorment"
    (slot value)
)
(deftemplate job "Job"
    (slot value)
)
(deftemplate stimulus_situation "Stimulus-situtation"
    (slot value)
)
(deftemplate stimulus_repsonse "Stimulus-Reponse"
    (slot value)
)
(deftemplate feedback "Feedback"
    (slot value)
)
(deftemplate medium "Medium"
    (slot value)
)

(deffunction ask-user ()
    (printout t "What sort of environment is a trainee dealing with on the job? " crlf)
    (bind ?e (read))
    (assert (enviorment (value ?e)))
    
    (printout t "What sort of job is a trainee dealing with? " crlf)
    (bind ?d (read))
    (assert (job (value ?d)))
    
    (printout t "Does the job require feedback? " crlf)
    (bind ?j (read))
    (assert (feedback (value ?j)))
    (run)
)

;(assert(enviorment(value paper)))
;(assert(enviorment(value machines)))
;(assert(enviorment(value advising)))
;(assert(job(value drawing)))
;(assert(feedback(value false)))

(defrule rule1 
    ?f <- (enviorment (value paper | manuals | documents | textbooks))
    =>
    (printout t "Verbal" crlf)
    (assert(stimulus_situation (value verbal)))
) 

(defrule rule2
    ?f <- (enviorment (value pictures | illustrations | photos | diagrams))
    =>
    (printout t "Visual" crlf)
    (assert(stimulus_situation (value visual)))
)

(defrule rule3
    ?f <- (enviorment (value machines | buildings | tools))
    =>
    (printout t "Physical Object" crlf)
    (assert (stimulus_situation (value physical-objects)))
)

(defrule rule4
    ?f <- (enviorment (value numbers | formulas | computer-programs))
    =>
    (printout t "Situation is symbolic" crlf)
    (assert (stimulation_situation (value symbolic)))
)

(defrule rule5
    ?f <- (job (value lecturing | advising | counselling))
    =>
    (printout t "Oral" crlf)
    (assert (stimulus_repsonse (value oral)))
)

(defrule rule6
    ?f <- (job (value buidling | repairing | troubleshooting))
    =>
    (printout t "Hands On" crlf)
    (assert (stimulus_reponse (value hands-on)))
)

(defrule rule7 
    ?f <- (job(value writing | typing | drawing))
    =>
    (printout t "Documented" crlf)
    (assert (stimulus_repsonse (value documented)))
)

(defrule rule8
    ?f <- (job (value evaluating | reasoning | investigating))
    =>
    (printout t "Analytical" crlf)
    (assert (stimulus_repsonse(value analytical)))
)

(defrule rule9
    ( stimulus_situation(value physical-objects))
    ( stimulus_repsonse(value hands-on))
    ( feedback(value true))
    =>
    (printout t "Medium workshop" crlf)
    (assert (medium(value workshop)))
)

(defrule rule10 
    ( stimulus_situation(value symbolic))
    ( stimulus_repsonse(value analytical))
    ( feedback(value true))
    =>
    (printout t "Medium Lecture-Tutorial" crlf)
    (assert (medium(value lecture-tutorial)))
)

(defrule rule11
    ( stimulus_situation(value visual))
    ( stimulus_repsonse(value documented))
    ( feedback(value false))
    =>
    (printout t "Medium Videocassette")
    (assert (medium(value videocassette)))
)

(defrule rule12
    ( stimulus_situation(value visual))
    ( stimulus_repsonse(value oral))
    ( feedback(value true))
    =>
    (printout t "Medium lecture tutorial")
    (assert (medium(value lecture-turtorial)))
)

(defrule rule13
    ( stimulus_situation(value verbal))
    ( stimulus_repsonse(value analytical))
    ( feedback(value true))
    =>
    (printout t "Medium lecture-tutorial" crlf)
    (assert(medium(value lecture-tutorial)))
)

(defrule rule14
    ( stimulus_situation(value verbal))
    ( stimulus_repsonse(value analytical))
    ( feedback(value true))
    =>
    (printout t "Medium role-play exercises" crlf)
    (assert (medium(value role-play-exercises)))
)

(run)