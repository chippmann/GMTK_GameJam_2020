extends Node

signal stageChanged

const timeInStageOne := 20 #60
const timeInStageTwo := 20 #120

export(PackedScene) var mainMenuPackedScene: PackedScene

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

var rhythmicHighScore: int = 0
var survivalHighScore: int = 0
var shootHighScore: int = 0

var deathReason := ""
var isInMainMenu := false

func _ready() -> void:
	yield(SoundPlayer, "ready")
	SoundPlayer.playMainMenu()


func startGame() -> void:
	changeStage(Stage.RHYTHMIC)
	emit_signal("stageChanged", Stage.RHYTHMIC)

func stopGame() -> void:
	if !isInMainMenu:
		currentStage = Stage.RHYTHMIC
		rhythmicScore = 0
		survivalScore = 0
		shootScore = 0
		deathReason = ""
		time = 0
		get_tree().change_scene_to(mainMenuPackedScene)
		SoundPlayer.playMainMenu()

var time: float = 0
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		stopGame()
		return
	if currentStage == Stage.SURVIVAL:
		time += delta
		if time >= 1:
			time -= 1
			survivalScore += 10

func changeStage(newStage: int) -> void:
	currentStage = newStage
	SoundPlayer.changeToStage(newStage)
	emit_signal("stageChanged", newStage)

func musicFinished() -> void:
	if currentStage == Stage.SHOOT: return
	changeStage(currentStage + 1)

func die() -> void:
	_setHighScore()
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
	startGame()


func _setHighScore() -> void:
	if rhythmicScore > rhythmicHighScore:
		rhythmicHighScore = rhythmicScore
	if survivalScore > survivalHighScore:
		survivalHighScore = survivalScore
	if shootScore > shootHighScore:
		shootHighScore = shootScore
