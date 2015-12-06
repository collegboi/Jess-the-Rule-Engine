(clear)
(reset)

(deftemplate person "Person Database"
  (slot age (default -1))
  (slot name)
  (slot gender))


(deftemplate oldest-male
  (slot name)
  (slot age))

(assert (person (gender Male) (name "Mitt Romney") (age 61) ))
(assert (person (name "Bob Smith") (age 34) (gender Male)))
(assert (person (gender Male) (name "Tom Smith") (age 32) ))
(assert (person (name "Mary Smith") (age 34) (gender Female)))
(assert (person  (name "George Bush") (gender Male)))


(defglobal ?*max* = 0 ?*max-name* = "")

(defrule oldest-male-rule
  ?y <- (person (gender Male) (name ?n) (age ?a))
  =>
  (if (> ?a ?*max*) then
        (bind ?*max* ?a)
        (bind ?*max-name* ?n)
    )
    (assert(oldest-male (name ?n) (age ?a)))
)


(defrule show-oldest-male
    ?y <- (oldest-male (name ?n) (age ?a))
    =>
    (printout t ?n " is the oldest " ?a crlf)
)

(deffunction find-oldest-male ()
    (assert (find-oldest))
    (run)
)

(defrule get-oldest-male
    ?f <- (find-oldest)
    ?y <- (oldest-male (age ?a))
    (person (name ?n) (age ?a & :(< ?a ?*max*)))
    =>
    (retract ?y)
    ;(retract ?f)
    (facts)
)

(run)
(find-oldest-male)
