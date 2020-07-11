extends Control


func _ready() -> void:
	$MarginContainer/VBoxContainer/MarginContainer2/Reason.text = GameManager.deathReason


func _on_Button_pressed() -> void:
	pass # Replace with function body.


func _on_RetryButton_pressed() -> void:
	GameManager.reset()


func _on_Quitbutton_pressed() -> void:
	get_tree().quit()
