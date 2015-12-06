
(clear)
    
;; **********************************************************************
;; Imports
    (import javax.swing.*)
    (import javax.swing.JFrame)
    (import javax.swing.border.EmptyBorder)
    (import java.awt.event.ActionListener)
    (import java.awt.BorderLayout)
    (import java.awt.GridLayout)
    (import java.awt.Color)
     
    ;; **********************************************************************
    ;;      Media Advisor rules
    ;; **********************************************************************
    ; Stimulus Situation
	(defrule rule1
            ?fact <- (environment "papers"|"manuals"|"documents"|"textbooks")
            =>
            (retract ?fact)
            (assert (stimulus-situation "verbal"))
    )
     
    (defrule rule2
            ?fact <- (environment "pictures"|"illustrations"|"photographs"|"diagrams")
            =>
            (retract ?fact)
            (assert (stimulus-situation "visual"))
    )
     
    (defrule rule3
            ?fact <- (environment "machines"|"buildings"|"tools")
            =>
            (retract ?fact)
            (assert (stimulus-situation "physical object"))
    )
     
    (defrule rule4
            ?fact <- (environment "numbers"|"formulas"|"computer programs")
            =>
            (retract ?fact)
            (assert (stimulus-situation "symbolic"))
    )
     
    ;; **********************************************************************
    ; Stimulus Response
    (defrule rule5
            ?fact <- (job "lecturing"|"advising"|"counselling")
            =>
            (retract ?fact)
            (assert (stimulus-response "oral"))
    )
     
    (defrule rule6
            ?fact <- (job "building"|"repairing"|"troubleshooting")
            =>
            (retract ?fact)
            (assert (stimulus-response "hands-on"))
    )
     
    (defrule rule7
            ?fact <- (job "writing"|"typing"|"drawing")
            =>
            (retract ?fact)
            (assert (stimulus-response "documented"))
    )
     
    (defrule rule8
            ?fact <- (job "evaluating"|"reasoning"|"investigating")
            =>
            (retract ?fact)
            (assert (stimulus-response "analytical"))
    )
     ;; **********************************************************************
    ; Medium
    (defrule rule9
            ?sit <- (stimulus-situation "physical object")
            ?resp <- (stimulus-response "hands-on")
            ?feedback <- (feedback-required TRUE)
            =>
            (retract ?sit)
            (retract ?resp)
            (retract ?feedback)
            (assert (medium workshop))
    )
     
    (defrule rule10
            ?sit <- (stimulus-situation "symbolic")
            ?resp <- (stimulus-response "analytical")
            ?feedback <- (feedback-required TRUE)
            =>
            (retract ?sit)
            (retract ?resp)
            (retract ?feedback)
            (assert (medium "lecture - tutorial"))
    )
     
    (defrule rule11
            ?sit <- (stimulus-situation "visual")
            ?resp <- (stimulus-response "documented")
            ?feedback <- (feedback-required FALSE)
            =>
            (retract ?sit)
            (retract ?resp)
            (retract ?feedback)
            (assert (medium videocassette))
    )
     
    (defrule rule12
            ?sit <- (stimulus-situation "visual")
            ?resp <- (stimulus-response "oral")
            ?feedback <- (feedback-required TRUE)
            =>
            (retract ?sit)
            (retract ?resp)
            (retract ?feedback)
            (assert (medium "lecture - tutorial"))
    )
     
    (defrule rule13
            ?sit <- (stimulus-situation "verbal")
            ?resp <- (stimulus-response "analytical")
            ?feedback <- (feedback-required TRUE)
            =>
            (retract ?sit)
            (retract ?resp)
            (retract ?feedback)
            (assert (medium "Lecture - tutorial"))
    )
     
    (defrule rule14
            ?sit <- (stimulus-situation "verbal")
            ?resp <- (stimulus-response "oral")
            ?feedback <- (feedback-required TRUE)
            =>
            (retract ?sit)
            (retract ?resp)
            (retract ?feedback)
            (assert (medium "Lecture - tutorial"))
    )
	
	(defrule rule15
            ?sit <- (stimulus-situation "visual")
            ?resp <- (stimulus-response "analytical")
            ?feedback <- (feedback-required TRUE)
            =>
            (retract ?sit)
            (retract ?resp)
            (retract ?feedback)
            (assert (medium "Flow-Charts"))
    )
	
	(defrule rule16
            ?sit <- (stimulus-situation "physical object")
            ?resp <- (stimulus-response "oral")
            ?feedback <- (feedback-required TRUE)
            =>
            (retract ?sit)
            (retract ?resp)
            (retract ?feedback)
            (assert (medium "Oral Description"))
    )
	(defrule rule17
            ?sit <- (stimulus-situation "verbal")
            ?resp <- (stimulus-response "hands-on")
            ?feedback <- (feedback-required TRUE)
            =>
            (retract ?sit)
            (retract ?resp)
            (retract ?feedback)
            (assert (medium "Instruction Booklet"))
    )
    
    (defrule rule18
        ?sit <- (stimulus-situation "visual")
        ?resp <- (stimulus-response "hands-on")
        ?feed <-(feedback-required TRUE)
        =>
        (retract ?sit)
        (retract ?resp)
        (retract ?feed)
        (assert(medium "Desgin"))
    )
    (defrule rule19
        ?sit <- (stimulus-situation "visual")
        ?resp <- (stimulus-response "hands-on")
        ?feed <-(feedback-required FALSE)
        =>
        (retract ?sit)
        (retract ?resp)
        (retract ?feed)
        (assert(medium "Help"))
    )
        
     (defrule rule20
        ?sit <- (stimulus-situation "visual")
        ?resp <- (stimulus-response "documented")
        ?feed <-(feedback-required FALSE | TRUE)
        =>
        (retract ?sit)
        (retract ?resp)
        (retract ?feed)
        (assert(medium "Typing Skills"))
    )
    ;; **********************************************************************
     
    ;; Main program
    ; Global defs
    (defglobal ?*frame* = 0)
    (defglobal ?*content* = 0)
    (defglobal ?*envbox* = 0)
    (defglobal ?*jobbox* = 0)
    (defglobal ?*feedback* = 0)
    (defglobal ?*output* = 0)
    (defglobal ?*color* = 0);colour
     
    ;; **********************************************************************
    ;; Main media advisor functionality
    ; Default medium rule, only fires if nothing else was found
    (defrule default
            ?done <- (done)
            ?sit <- (stimulus-situation ?)
            ?resp <- (stimulus-response ?)
            ?feedback <- (feedback-required ?)
            =>
            (retract ?sit)
            (retract ?resp)
            (retract ?feedback)
            (assert (medium unknown))
    )
     ;; **********************************************************************
    ; Medium found, change text on the jlabel
    (defrule result
            ?done <- (done)
            ?mediumFound <- (medium ?m)
            =>
            (retract ?done)
            (retract ?mediumFound)
            (set-output ?m)
            (printout t "Medium is " ?m crlf)
    )
    ;; **********************************************************************
    ; Find medium function
    (deffunction find-medium (?e ?j ?f)
            (assert (environment ?e))
            (assert (job ?j))
            (assert (feedback-required ?f))
            (run)
            (assert (done))
            (run)
    )
     
    ;; **********************************************************************
    ; Create frame
    (deffunction create-frame ()
         (bind ?*frame* (new JFrame "Jess Reflection Demo"))
         (bind ?*color* (?*frame* getContentPane)) 
         (set ?*color* background (Color.cyan))
    )
    ;; **********************************************************************
     
    ; Add content to the frame
    (deffunction add-widgets ()
            ;; Create all panels
            (bind ?*envbox* (new JComboBox))
            (?*envbox* addItem "papers")
            (?*envbox* addItem "manuals")
            (?*envbox* addItem "documents")
            (?*envbox* addItem "textbooks")
            (?*envbox* addItem "pictures")
            (?*envbox* addItem "illustrations")
            (?*envbox* addItem "photographs")
            (?*envbox* addItem "diagrams")
            (?*envbox* addItem "machines")
            (?*envbox* addItem "tools")
            (?*envbox* addItem "numbers")
            (?*envbox* addItem "formulas")
            (?*envbox* addItem "computer programs")
            (?*color* add ?*envbox* (BorderLayout.NORTH))
     
            (bind ?*jobbox* (new JComboBox))
            (?*jobbox* addItem "lecturing")
            (?*jobbox* addItem "advising")
            (?*jobbox* addItem "counselling")
            (?*jobbox* addItem "building")
            (?*jobbox* addItem "repairing")
            (?*jobbox* addItem "troubleshooting")
            (?*jobbox* addItem "writing")
            (?*jobbox* addItem "typing")
            (?*jobbox* addItem "drawing")
            (?*jobbox* addItem "evaluating")
            (?*jobbox* addItem "reasoning")
            (?*jobbox* addItem "investigating")
            (?*color* add ?*jobbox* (BorderLayout.CENTER))
     
            (bind ?*feedback* (new JCheckBox))
            (?*feedback* setSelected TRUE)
            (?*color* add ?*feedback*)
     
            (?*color* add (new JPanel))
            (bind ?button (new JButton "Generate medium"))
     
            (?*color* add (new JLabel "The suggested medium is: "))
            (bind ?*output* (new JLabel))
     
            ;; Add behaviour to the button panel
            (?button addActionListener
                    (implement ActionListener using
                            (lambda (?name ?event)
                                    (find-medium
                                            (?*envbox* getSelectedItem)
                                            (?*jobbox* getSelectedItem)
                                            (?*feedback* isSelected)
                                    )
                            )
                    )
            )
    )
     
    ; Show the frame
    (deffunction show-frame ()
        ;(?*frame* pack)
        (?*frame* setSize 200 300)
        (?*frame* setVisible TRUE)
    )
  
    ; Change text on the output label
    (deffunction set-output (?t)
            (?*output* setText ?t)
    )
     
    ;; **********************************************************************
    ;; Main program init
    (defrule init
            ?f <- (initial-fact)
            =>
            (retract ?f)
            (create-frame)
            (add-widgets)
            (show-frame)
    )
    ;; **********************************************************************
     
    (reset)
    (run)

    