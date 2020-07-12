extends Control


export(PackedScene) var discoPackedScene: PackedScene

func _ready() -> void:
	GameManager.isInMainMenu = true

func _exit_tree() -> void:
	GameManager.isInMainMenu = false

func _on_PlayButton_pressed() -> void:
	get_tree().change_scene_to(discoPackedScene)
	GameManager.startGame()


func _on_QuitButton_pressed() -> void:
	get_tree().quit()
