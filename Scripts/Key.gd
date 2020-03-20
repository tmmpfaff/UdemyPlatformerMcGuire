extends Node2D

func _ready() -> void:
	pass


func _on_Area2D_body_entered(body: PhysicsBody2D) -> void:
	if "Player" in body.name:
		body.win_condition()	#func ist in Player.gd
		queue_free()
