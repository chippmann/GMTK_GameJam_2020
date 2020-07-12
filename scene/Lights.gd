extends Spatial
class_name Lights

export(PackedScene) var fallingLightPackedScene: PackedScene

onready var light0: SpotLight = $SpotLight
onready var light1: SpotLight = $SpotLight2
onready var light2: SpotLight = $SpotLight3
onready var light3: SpotLight = $SpotLight4

var nextColorChange := 0.0
var nextRotationChange := 0.0

var light0Color = _getLightColor()
var light1Color = _getLightColor()
var light2Color = _getLightColor()
var light3Color = _getLightColor()

var rotationTarget = 0.0

var floorMeshInstanceSize: Vector2 = Vector2(40, 40)

func _ready() -> void:
	randomize()

func _process(delta: float) -> void:
	_setLighing()
	if GameManager.currentStage >= GameManager.Stage.SURVIVAL:
		_fallingLights(delta)


var fallingLightsTimeInterval := 1.0
var fallingLightTime := 0.0
func _fallingLights(delta: float) -> void:
	fallingLightTime += delta
	if fallingLightTime > fallingLightsTimeInterval:
		if fallingLightsTimeInterval > 0.05:
			fallingLightsTimeInterval -= 0.01
		fallingLightTime -= fallingLightsTimeInterval
		var randomPositionX := randi() % int(floorMeshInstanceSize.x) - 20
		var randomPositionZ := randi() % int(floorMeshInstanceSize.y) - 20
		var spawnPosition := Vector3(randomPositionX, global_transform.origin.y + 40, randomPositionZ)
		var fallingLight: FallingLight = fallingLightPackedScene.instance()
		fallingLight.transform.origin = spawnPosition
		get_parent().add_child(fallingLight)

func _setLighing() -> void:
	if nextRotationChange < OS.get_ticks_msec():
		nextRotationChange = OS.get_ticks_msec() + 200
		rotationTarget = SoundPlayer.wholeSpectrumEnergy * TAU
	
	rotation.y = lerp(rotation.y, rotationTarget, 0.5)
	
	light0.light_energy = lerp(light0.light_energy, _getLightEnergy(0), 0.75)
	light1.light_energy = lerp(light1.light_energy, _getLightEnergy(1), 0.75)
	light2.light_energy = lerp(light2.light_energy, _getLightEnergy(2), 0.75)
	light3.light_energy = lerp(light3.light_energy, _getLightEnergy(3), 0.75)
	
	light0.light_color = lerp(light0.light_color, light0Color, 0.1)
	light1.light_color = lerp(light1.light_color, light1Color, 0.1)
	light2.light_color = lerp(light2.light_color, light2Color, 0.1)
	light3.light_color = lerp(light3.light_color, light3Color, 0.1)
	
	if nextColorChange < OS.get_ticks_msec():
		nextColorChange = OS.get_ticks_msec() + 2000
		light0Color = _getLightColor()
		light1Color = _getLightColor()
		light2Color = _getLightColor()
		light3Color = _getLightColor()

func _getLightEnergy(light: int) -> float:
	var lightEnergy: float = 0
	for i in range(light, light * 4):
		lightEnergy +=  SoundPlayer.spectrumEnergy[i]
	lightEnergy /= 4
	lightEnergy *= 2
	return lightEnergy + 1

func _getLightColor() -> Color:
	return Color(randf(), randf(), randf())
