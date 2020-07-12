extends Control


func _ready() -> void:
	$MarginContainer/VBoxContainer/MarginContainer2/Reason.text = GameManager.deathReason
	$MarginContainer/VBoxContainer/MarginContainer5/Score.text = """Rythmic: %s
Survival: %s
Out of Control: %s
""" % [GameManager.rhythmicScore, GameManager.survivalScore, GameManager.shootScore]
	$MarginContainer/VBoxContainer/MarginContainer7/HighScore.text = """Rythmic: %s
Survival: %s
Out of Control: %s
""" % [GameManager.rhythmicHighScore, GameManager.survivalHighScore, GameManager.shootHighScore]



func _on_RetryButton_pressed() -> void:
	GameManager.reset()


func _on_Quitbutton_pressed() -> void:
	get_tree().quit()
