extends KinematicBody
class_name Enemy

const moveSpeedMultiplier = 1
const moveSpeedPanicMultiplier = 2
const moveSpeed := 10

export(NodePath) var navigationNodePath: NodePath
onready var navigation: Navigation = get_node(navigationNodePath)

var floorMeshInstanceSize: Vector2 = Vector2(40, 40)

var path := []
var pathIndex = 0
var isPanicing := false

#func _ready() -> void:
#	$MeshInstance2.set_as_toplevel(true)

var waiting := false
func _physics_process(delta: float) -> void:
	if waiting: return
	if pathIndex < path.size():
		var moveVector: Vector3 = (path[pathIndex] - global_transform.origin)
		if abs(moveVector.x) < 1 && abs(moveVector.z) < 1:
			pathIndex += 1
		else:
			if isPanicing:
				move_and_slide(moveVector.normalized() * moveSpeed * moveSpeedPanicMultiplier, Vector3.UP)
			else:
				move_and_slide(moveVector.normalized() * moveSpeed * moveSpeedMultiplier, Vector3.UP)
	else:
		if !isPanicing:
			waiting = true
			yield(get_tree().create_timer(5), "timeout")
			waiting = false
		var randomPositionX := randi() % int(floorMeshInstanceSize.x) - 20
		var randomPositionZ := randi() % int(floorMeshInstanceSize.y) - 20
#		$MeshInstance2.transform.origin = Vector3(randomPositionX, global_transform.origin.y, randomPositionZ)
		path = navigation.get_simple_path(global_transform.origin, Vector3(randomPositionX, global_transform.origin.y, randomPositionZ))
		pathIndex = 0


func _on_Area_body_entered(body: Node) -> void:
	if !body.is_in_group("player"): return
	var currentGameStage = GameManager.currentStage
	match(currentGameStage):
		GameManager.Stage.RHYTHMIC:
			GameManager.rhythmicScore -= 10
			if GameManager.rhythmicScore < 0:
				GameManager.rhythmicScore = 0
		GameManager.Stage.SHOOT:
			GameManager.shootScore += 2
