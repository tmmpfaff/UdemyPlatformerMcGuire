extends CanvasLayer

func _ready() -> void:
	#alternativ kann man über Node/Groups Add auch eine Gruppe anlegen. Dies ist die ScrptVersion
	add_to_group("GUI")
	

func updateGUI(lives):
	if lives <=0:
		$PopupDialog.show()
		#get_tree().paused = true
		

func _on_Playagain_pressed() -> void:
	get_tree().paused =false
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
	

func _on_Quit_pressed() -> void:
	get_tree().quit()
	
func Winner():
	$PopupDialogWin.show()
	#get_tree().paused = true
