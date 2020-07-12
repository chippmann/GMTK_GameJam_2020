extends Node

signal stageChanged

const timeInStageOne := 20 #60
const timeInStageTwo := 20 #120

enum Stage {
	RHYTHMIC,
	SURVIVAL,
	SHOOT,
	GAME_OVER
}

var currentStage: int = Stage.RHYTHMIC

var rhythmicScore: int = 0
var survivalScore: int = 0
var shootScore: int = 0
var deathReason := ""

func _ready() -> void:
	_startGame()


func _startGame() -> void:
	changeStage(Stage.RHYTHMIC)
	emit_signal("stageChanged", Stage.RHYTHMIC)

var time: float = 0
func _process(delta: float) -> void:
	if currentStage == Stage.SURVIVAL:
		time += delta
		if time >= 1:
			time -= 1
			survivalScore += 1

func changeStage(newStage: int) -> void:
	currentStage = newStage
	SoundPlayer.changeToStage(newStage)
	emit_signal("stageChanged", newStage)

func musicFinished() -> void:
	if currentStage == Stage.SHOOT: return
	changeStage(currentStage + 1)

func die() -> void:
	print("died!")
	return
	get_tree().change_scene("res://ui/GameOver.tscn")
	changeStage(Stage.GAME_OVER)

func reset() -> void:
	currentStage = Stage.RHYTHMIC
	rhythmicScore = 0
	survivalScore = 0
	shootScore = 0
	deathReason = ""
	time = 0
	get_tree().change_scene("res://scene/Disco.tscn")
	_startGame()
