;;Domain for cleaning floor tiles
;; A domain file for CMP2020M assignment 2021/2022

;; Define the name for this domain (needs to match the domain definition
;;   in the problem files)

(define (domain floor-tile)

	;; We only require some typing to make this plan faster. We can do without!
	(:requirements :typing)

	;; We have two types: robots and the tiles, both are objects
	(:types robot tile - object)

	;; define all the predicates as they are used in the probem files
	(:predicates  

    ;; described what tile a robot is at
    (robot-at ?r - robot ?x - tile)

    ;; indicates that tile ?x is above tile ?y
    (up ?x - tile ?y - tile)

    ;; indicates that tile ?x is below tile ?y
    (down ?x - tile ?y - tile)

    ;; indicates that tile ?x is right of tile ?y
    (right ?x - tile ?y - tile)

    ;; indicates that tile ?x is left of tile ?y
    (left ?x - tile ?y - tile)
    
    ;; indicates that a tile is clear (robot can move there)
    (clear ?x - tile)

    ;; indicates that a tile is cleaned
    (cleaned ?x - tile)
 	)
;;each predicate used in preconditions must be true for an action to occur, otherwise the action does not occur

;; action: clean up action which takes two tile objects and a robot object and tells the robot to clean the tile above it
;; preconditions: the tile y must be directly above tile x, the robot must be at tile x, tile y must be clear and not cleaned (therefore meaning nothing is obstructing it)
;; effect: the result will be that tile y will be cleaned (and therefore not traversable)
(:action clean-up
  :parameters (?r - robot ?x - tile ?y - tile)
  :precondition(and (up ?y ?x) (robot-at ?r ?x)  (clear ?y) (not(cleaned ?y)))
  :effect (and (cleaned ?y))                                            
 )

;; action: clean down action which takes two tile objects and a robot object and clean the tile below it
;; preconditions: the tile y must be directly below tile x, the robot must be at tile x, tile y must be clear and not cleaned (therefore meaning nothing is obstructing it)
;; effect: the result will be that tile y will be cleaned (and therefore not traversable)
 (:action clean-down
  :parameters (?r - robot ?x - tile ?y - tile)
  :precondition(and (down ?y ?x) (robot-at ?r ?x) (clear ?y) (not(cleaned ?y)))
  :effect (and (cleaned ?y))
 )
;; action: up action which takes a robot object and two tile objects x and y and tells the robot to move up
;; preconditions: the tile y must be directly above tile x, the robot must be at tile x. Tile y must be clear and not cleaned
;; effect: the tile y will not be clear as it is occupied by a robot, tile x will now be clear, the robot will now be at tile y and not at tile x
 (:action up
  :parameters (?r - robot ?x - tile ?y - tile)
  :precondition(and (up ?y ?x) (robot-at ?r ?x) (not(cleaned ?y)) (clear ?y))
  :effect (and (not(clear ?y)) (clear ?x) (robot-at ?r ?y) (not(robot-at ?r ?x)))
 )

;; action: down action which takes a robot object and two tile objects x and y and tells the robot to move down
;; preconditions: the tile y must be directly below tile x, the robot must be at tile x. Tile y must be clear and not cleaned
;; effect: the tile y will not be clear as it is occupied by a robot, tile x will now be clear, the robot will now be at tile y and not at tile x
 (:action down
  :parameters (?r - robot ?x - tile ?y - tile)
  :precondition(and (down ?y ?x) (robot-at ?r ?x) (not(cleaned ?y)) (clear ?y))
  :effect (and (not(clear ?y)) (clear ?x) (robot-at ?r ?y) (not(robot-at ?r ?x)))
 )
;; action: right action which takes a robot object and two tile objects x and y and tells the robot to move right
;; preconditions: the tile y must be directly to the right of tile x, the robot must be at tile x. Tile y must be clear and not cleaned
;; effect: the tile y will not be clear as it is occupied by a robot, tile x will now be clear, the robot will now be at tile y and not at tile x
 (:action right
  :parameters (?r - robot ?x - tile ?y - tile)
  :precondition(and (right ?y ?x) (robot-at ?r ?x) (not(cleaned ?y)) (clear ?y))
  :effect (and (not(clear ?y)) (clear ?x) (robot-at ?r ?y) (not(robot-at ?r ?x)))
 )
;; action: left action which takes a robot object and two tile objects x and y and tells the robot to move left
;; preconditions: the tile y must be directly to the left of tile x, the robot must be at tile x. Tile y must be clear and not cleaned
;; effect: the tile y will not be clear as it is occupied by a robot, tile x will now be clear, the robot will now be at tile y and not at tile x
 (:action left
  :parameters (?r - robot ?x - tile ?y - tile)
  :precondition(and (left ?y ?x) (robot-at ?r ?x) (not(cleaned ?y)) (clear ?y))
  :effect (and (not(clear ?y)) (clear ?x) (robot-at ?r ?y) (not(robot-at ?r ?x)))
 )


)
;;references
;;Helmert, M (2011) An Introduction to PDDL [lecture]. AI Planning, University of Toronto, October 16th. Available from: https://www.cs.toronto.edu/~sheila/2542/s14/A1/introtopddl2.pdf [accessed 3 May 2022]
;;Cuayahuitl, H (2022) Planning I [lecture]. CMP2020M Artificial Intelligence, University of Lincoln, May 2nd. Available from: https://learn-eu-central-1-prod-fleet01-xythos.content.blackboardcdn.com/5eec76bac93d5/7663144?X-Blackboard-Expiration=1652572800000&X-Blackboard-Signature=qDwX6%2BlTRCIRhB4LBxMa0fLW%2BxVGxm6JF6uH1ccxWX4%3D&X-Blackboard-Client-Id=307403&response-cache-control=private%2C%20max-age%3D21600&response-content-disposition=inline%3B%20filename%2A%3DUTF-8%27%27CMP2020M%252009%2520Planning%2520I.pdf&response-content-type=application%2Fpdf&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEKL%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaDGV1LWNlbnRyYWwtMSJHMEUCIDbf3t8wiiklzO%2BGYk0WlzHA%2FxFtiJYu0RuP53xKSFcOAiEAyfYQDmlvQagLExTey12xFBbzS%2FmBKA6V6T8idFvMOt8q3AQIexACGgw2MzU1Njc5MjQxODMiDIP0xbRQnSi0v%2FuR5Sq5BMg9N4RoJ5UQuKLuIZwpWkAowr9LLBeJ2KikAemTxI971QCP6BM3lMVLbgAp%2F4WXijLMtAnkUOmFvO3Wgyo7sjZo8RVB%2FFnsXsHOWx%2Fi0GTXSx3aoz4ZQ%2FqMyz%2BK4znPPyZ4mkJCEqVFL%2B1lnT1ZZ5c%2BAZ4EDqBN8kQt5pB2ppcLXj0%2BHfdr6tsA5dyFyKwaM4lAAYWgyJSg%2B6DlyqkFJR1R8KnLn%2FJ4oh6FSju3fSrFzNe%2F%2BpKulv7ygzgHDKGGEHtoWui17HzwRAMd2QUyleyHIy3re2ek5AWEs3MULRlwWr2r4j8ddtJtJVg%2Br3EraoFuDbdl3jvwTUNxjnkFBhhuBtKo%2FRGSKnwKsZFyAzPs%2BviRO3GWeI0g5xorYYrQzlMb6URClSO9VdbpcKNxIk3Hcwd%2BsDLCP%2BhhHGxhvWWEX%2Bpf0DFgHucJ3mR44eu3DkP5lMLr2QRX9dtOLeTlXDAr2SMu8W%2Fhe%2BcLHCHsQO2OXHl1GwerOHyrizkgDBXpim4YgoFNVoGZ2wkJthRi1aZgqNbSn5DqNgIdy%2FlfHufjLYz1OFZjaTSp3GYhtIJpqMNTNDgy82OIGjfvtWHv1Yy2Bc3F5XR3GyVnpeulMIvLhjPJLUf5U8WvpC9hueadYKCMfxdg3xJXzHDM2In8%2BMYooUEF6yTR%2Fd%2FVSCeg9%2F964s%2F7g0OUp4LT%2BnCGaOLS%2BZNe4D7fIDgp0CHtpGBBSYSoG%2FafHTGBRnLbGnmxTlghpYgEZdW0snzqMPzj%2F5MGOqkBdRkAYRZQ61kihGRBln64CLanvkNjxsC7ohZ3f%2BiZeYJ%2BQXpGsHkiWk5rbd8DBF9Je%2BF4m7W%2FsF5q%2FmpZB7%2Fs8dmomLWOA1S3Vcx%2BNuTGDMTxsiEIWWQn31%2F5SbI2jaieopE4DdpmYw0rwtLdXmGqdeouG3M5%2BrvUpY8hT539ZTA7bStG8iV4ljE9Tl12m6Nz%2BJhyuWReONSgm9c52hZAkzrf7gkJ536edQ%3D%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20220514T180000Z&X-Amz-SignedHeaders=host&X-Amz-Expires=21600&X-Amz-Credential=ASIAZH6WM4PL7HENUWNZ%2F20220514%2Feu-central-1%2Fs3%2Faws4_request&X-Amz-Signature=058daea627d22459597da96d78c92e27bd69e2fcd85d22d059cd53f1c6c6ee21 [accessed 2 May 2022]                     
  

