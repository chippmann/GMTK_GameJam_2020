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

var health := 100

func _ready() -> void:
	randomize()
#	$MeshInstance2.set_as_toplevel(true)

var waiting := false
func _physics_process(delta: float) -> void:
	isPanicing = GameManager.currentStage >= GameManager.Stage.SURVIVAL
	if waiting: return
	if pathIndex < path.size():
		var moveVector: Vector3 = (path[pathIndex] - global_transform.origin)
		if abs(moveVector.x) < 1 && abs(moveVector.z) < 1:
			pathIndex += 1
		else:
			if isPanicing:
				var velocity = moveVector.normalized() * moveSpeed * moveSpeedPanicMultiplier
				if !is_on_floor():
					velocity.y -= 9.81 * moveSpeedMultiplier
				move_and_slide(velocity, Vector3.UP)
			else:
				var velocity = moveVector.normalized() * moveSpeed * moveSpeedMultiplier
				if !is_on_floor():
					velocity.y -= 9.81 * moveSpeedMultiplier
				move_and_slide(velocity, Vector3.UP)
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
	if !body.is_in_group("player") && !body.is_in_group("bullet"): return
	var currentGameStage = GameManager.currentStage
	match(currentGameStage):
		GameManager.Stage.RHYTHMIC:
			GameManager.rhythmicScore -= 10
			if GameManager.rhythmicScore < 0:
				GameManager.rhythmicScore = 0
		GameManager.Stage.SURVIVAL:
			if body.is_in_group("player"):
				GameManager.survivalScore -= 5
				if GameManager.survivalScore < 0:
					GameManager.survivalScore = 0
		GameManager.Stage.SHOOT:
			if body.is_in_group("bullet"):
				GameManager.shootScore += 2


func damage(value: int) -> void:
	health -= value
	if health <= 0:
		waiting = true
		visible = false
		var spawnPoints = get_tree().get_nodes_in_group("spawn")
		var spawnPoint = spawnPoints[randi() % spawnPoints.size()]
		transform.origin = spawnPoint.transform.origin
		health = 100
		path = []
		pathIndex = 0
		visible = true
		while !is_on_floor():
			yield(get_tree().create_timer(0.2), "timeout")
		waiting = false
