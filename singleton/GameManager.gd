extends Node

signal stageChanged

const timeInStageOne := 60
const timeInStageTwo := 120

enum Stage {
	RHYTHMIC,
	SURVIVAL,
	SHOOT
}

var currentStage: int = Stage.RHYTHMIC

var rhythmicScore: int = 0
var survivalScore: int = 0
var shootScore: int = 0

func _ready() -> void:
	yield(get_tree().create_timer(timeInStageOne), "timeout")
	_changeStage(Stage.SURVIVAL)
	yield(get_tree().create_timer(timeInStageTwo), "timeout")
	_changeStage(Stage.SHOOT)

func _changeStage(newStage: int) -> void:
	currentStage = newStage
	SoundPlayer.changeToStage(newStage)
	emit_signal("stageChanged", newStage)
