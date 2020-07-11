extends Control
class_name UI

onready var tutorialContainer: MarginContainer = $MarginContainer/HBoxContainer/TutorialUiContainer
onready var tutorialContainerTween: Tween = $MarginContainer/HBoxContainer/TutorialUiContainer/Tween
onready var tutorialText: Label = $MarginContainer/HBoxContainer/TutorialUiContainer/MarginContainer2/VBoxContainer/TutorialText
onready var scoreLabel: Label = $MarginContainer/HBoxContainer/ScoreLabel


func _ready() -> void:
	GameManager.connect("stageChanged", self, "_onStageChanged")
	tutorialContainer.modulate.a = 0
	yield(get_tree().create_timer(2.0), "timeout")
	_onStageChanged(0)

func _process(delta: float) -> void:
	match(GameManager.currentStage):
		GameManager.Stage.RHYTHMIC:
			scoreLabel.text = "Score: %s" % GameManager.rhythmicScore
		GameManager.Stage.SURVIVAL:
			scoreLabel.text = "Time Score: %s" % GameManager.survivalScore
		GameManager.Stage.SHOOT:
			scoreLabel.text = "Score: %s" % GameManager.shootScore

func _onStageChanged(newStage: int) -> void:
	match(newStage):
		GameManager.Stage.RHYTHMIC:
			_onStageRhythmicEnter()
		GameManager.Stage.SURVIVAL:
			_onStageSurvivalEnter()
		GameManager.Stage.SHOOT:
			_onStageShootEnter()


func _onStageRhythmicEnter() -> void:
	tutorialText.text = "Time to Dance!\nShow off your dancing skills by\ndancing to the fields using\nW, A, S, D or your JoyStick.\nBe super fast with Shift"
	_showAndHideTutorialContainer()


func _onStageSurvivalEnter() -> void:
	tutorialText.text = "What's that?\nOh now the sound is too intense!\nThe disco is collapsing.\nPay attention to your sourroundings!"
	_showAndHideTutorialContainer()


func _onStageShootEnter() -> void:
	tutorialText.text = "Oh god... Now everything is\nOut of Control!\nQuick, use this gun (which is\ntotally NOT just teleported in your hands)\nand survive this hell..."
	_showAndHideTutorialContainer()


func _showAndHideTutorialContainer() -> void:
	tutorialContainer.visible = true
	tutorialContainerTween.interpolate_property(tutorialContainer, "modulate:a", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tutorialContainerTween.start()
	yield(tutorialContainerTween, "tween_completed")
	yield(get_tree().create_timer(15.0), "timeout")
	tutorialContainerTween.interpolate_property(tutorialContainer, "modulate:a", 1, 0, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tutorialContainer.visible = false
	tutorialContainerTween.start()
