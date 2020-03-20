extends Node2D

func _ready() -> void:
	pass

func _on_Area2D_body_entered(body: PhysicsBody2D) -> void:
	if "Player" in body.name:
		Global.points=Global.points+1
		$AnimationPlayer.play("Obtained")
		$Area2D/CollisionShape2D.disabled = true
		print("Global.points: ",Global.points)

# warning-ignore:unused_argument
func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	queue_free()
