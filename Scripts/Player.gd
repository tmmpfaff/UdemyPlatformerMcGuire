extends KinematicBody2D

var velocity: Vector2 = Vector2.ZERO
var speed: int = 200
var jumpSpeed: int = 600
var jumpCount: int = 0
var lives: int = 3
var has_won: bool = false

const GRAVITY: float = 25.0
const UP: Vector2 = Vector2.UP		#entspricht Vector2(0,-1)


func _ready() -> void:
	pass
	
func hurt():
	if lives > 0:
		lives -=1
		print("Leben: ",lives)
	if lives <=0:
		updateGUI()
		
		
func enemyJump():
	velocity.y = -jumpSpeed

# warning-ignore:unused_argument
func _physics_process(delta: float) -> void:
	move()
	animate()
	jump()
	applyGravity()
# warning-ignore:return_value_discarded
	move_and_slide(velocity,UP)
	
func move():
	if Input.is_action_pressed("left"):
		velocity.x = -speed
	elif Input.is_action_pressed("right"):
		velocity.x = speed
	else:
		velocity.x = 0
		

func jump():
	# jumpCount <2 ist zweifacher Sprung bzw.<3 wäre dreifacher Sprung
	if Input.is_action_just_pressed("ui_select") and jumpCount <2:
		velocity.y = -jumpSpeed 
		jumpCount +=1
	elif is_on_floor():	# einfacher Sprung
		jumpCount = 0
	
		

func applyGravity():
	if not is_on_floor():
		velocity.y += GRAVITY			
	
func animate():
	if velocity.y < 0:
		$AnimatedSprite.play("Jump")
	elif velocity.x !=0:
		$AnimatedSprite.play("Walk")
		$AnimatedSprite.flip_h = velocity.x <0	#Seitenwechsel bei rechts und links
	else:
		$AnimatedSprite.play("Idle")
		
func updateGUI():
	get_tree().call_group("GUI","updateGUI",lives)
	
func win_condition():
	has_won = true	
	updateWinner()
	
func updateWinner():
	get_tree().call_group("EXIT","update_Winner",has_won)
