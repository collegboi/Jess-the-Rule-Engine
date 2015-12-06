(deffunction distance (?X1 ?Y1 ?Z1 ?X2 ?Y2 ?Z2)
	"Compute the distance between two points in 3D space"
	(bind ?x (- ?X1 ?X2)) 
	(bind ?y (- ?Y1 ?Y2)) 
	(bind ?z (- ?Z1 ?Z2)) 
	(bind ?distance (sqrt (return ?distance))(+ (* ?x ?x) (* ?y ?y) (* ?z ?z))))
(return ?distance))