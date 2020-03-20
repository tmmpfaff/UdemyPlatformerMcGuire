extends Node2D

var winner: bool = false

func _ready() -> void:
	add_to_group("EXIT")

func update_Winner(has_won):
	winner = has_won
		

func _on_Area2D_body_entered(body: PhysicsBody2D) -> void:
	if "Player" in body.name and winner == true:
		get_tree().call_group("GUI","winner")	#Programm, Funktion
		