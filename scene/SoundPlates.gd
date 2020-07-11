extends Spatial
class_name SoundPlates


func _ready() -> void:
	randomize()
	GameManager.connect("stageChanged", self, "_onStageChanged")
	for child in get_children():
		(child as Plate).connect("steppedOn", self, "onSteppedOn")
	_onStageChanged(GameManager.Stage.RHYTHMIC)
	onSteppedOn()


func onSteppedOn(plate: Plate = null) -> void:
	if plate:
		plate.visible = false
	
	_getRandomPlate(plate).visible = true

func _getRandomPlate(currentPlate: Plate) -> Plate:
	var plate = get_child(randi() % get_child_count()) as Plate
	if plate == currentPlate:
		return _getRandomPlate(currentPlate)
	return plate

func _onStageChanged(stage: int) -> void:
	if stage == GameManager.Stage.RHYTHMIC:
		visible = true
	else:
		visible = false
