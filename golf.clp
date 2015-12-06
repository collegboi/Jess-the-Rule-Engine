(clear)
(reset)
(deftemplate golfer (slot name) (slot colour) (slot pos))

(defrule init-rule
    (initial-fact)
    =>
    (foreach ?n (create$ fred joe tom bob)
        (foreach ?c (create$ red blue plaid orange)
            (foreach ?p (create$ 1 2 3 4)
                (assert (golfer (name ?n) (pos ?p) (colour ?c)))
            )
         )
     )
)     

(defrule get-soln
    (golfer (name joe) (pos ?p1 & 2) (colour ?c1))
    (golfer (name bob) (pos ?p2 & ~?p1) (colour ?c2 & plaid & ~?c1))
    (golfer (name tom) (pos ?p3 & ~1 & ~4 & ~?p1 & ~?p2) 
                       (colour ?c3 & ~orange & ~?c1 & ~?c2))
    (golfer (name fred) (pos ?p4 & ~?p3 & ~?p1 & ~?p2) 
                       (colour ?c4 & ~?c3 & ~?c1 & ~?c2 & ~blue))
    (golfer (name ?n& ~fred & ~bob) (colour ?c & blue)
                      (pos ?p & :(= ?p (+ ?p4 1))))
    
    =>
    (printout t "Joe is  " ?p1 " wearing " ?c1 crlf)
    (printout t "Bob is  " ?p2 " wearing " ?c2 crlf)
    (printout t "Tom is  " ?p3 " wearing " ?c3 crlf)
    (printout t "Fred is " ?p4 " wearing " ?c4 crlf)
    (printout t ?n " is " ?p " wearing " ?c crlf)
    (printout t crlf)
)    