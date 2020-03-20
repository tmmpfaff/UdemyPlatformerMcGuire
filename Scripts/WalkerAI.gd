extends KinematicBody2D

const SPEED: int = 80
const GRAVITY: int = 50
const UP: Vector2 = Vector2.UP

var velocity: Vector2 = Vector2.ZERO
var direction: int = 1
var is_dead: bool = false


# warning-ignore:unused_argument
func _process(delta: float) -> void:
	Movement()
	
func Death():	#When Enemy is killed
	is_dead = true
	$AnimatedSprite.play("Dead")
	$CollisionShape2D.disabled = true
	$EnemyDamage/CollisionShape2D.disabled = true
	$PlayerDamage/CollisionShape2D.disabled = true
	velocity.x = 0	#stop moving
	yield(get_tree().create_timer(1),"timeout")	#scripts waits 1 second
	queue_free()	#delete the enemy
	
	
func Movement():
	if is_dead == false:	#When enemy is alive
		velocity.x = SPEED * direction	# goes on the x- Axis left and right
		if direction ==1:
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.flip_h = true	
		$AnimatedSprite.play("Walk")
		velocity.y+=GRAVITY
# warning-ignore:return_value_discarded
		move_and_slide(velocity,UP)
		
		if is_on_wall():		#Bei Berührung mit Wand,oder Tileset
			direction *=-1		#ändert der Enemy die Richtung	
			$RayCast2D.position.x *=-1
		
		if $RayCast2D.is_colliding() == false:
			direction *=-1
			$RayCast2D.position.x *=-1			

func _ready() -> void:
	pass

func _on_PlayerDamage_body_entered(body: PhysicsBody2D) -> void:
	if "Player" in body.name:
		body.hurt()		#func ist in Player

func _on_EnemyDamage_body_entered(body: PhysicsBody2D) -> void:
	if "Player" in body.name:
		body.enemyJump()	#func ist in Player
		Death()
