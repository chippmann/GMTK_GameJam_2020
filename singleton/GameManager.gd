extends Node

signal stageChanged

const timeInStageOne := 20 #60
const timeInStageTwo := 20 #120

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

var time: float = 0

func _process(delta: float) -> void:
	if currentStage == Stage.SURVIVAL:
		time += delta
		if time >= 1:
			time -= 1
			survivalScore += 1

func _changeStage(newStage: int) -> void:
	currentStage = newStage
	SoundPlayer.changeToStage(newStage)
	emit_signal("stageChanged", newStage)
