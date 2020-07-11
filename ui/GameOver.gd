extends Control


func _ready() -> void:
	$MarginContainer/VBoxContainer/MarginContainer2/Reason.text = GameManager.deathReason
	$MarginContainer/VBoxContainer/MarginContainer5/Score.text = """Rythmic: %s
Survival: %s
Out of Control: %s
""" % [GameManager.rhythmicScore, GameManager.survivalScore, GameManager.shootScore]


func _on_Button_pressed() -> void:
	pass # Replace with function body.


func _on_RetryButton_pressed() -> void:
	GameManager.reset()


func _on_Quitbutton_pressed() -> void:
	get_tree().quit()
