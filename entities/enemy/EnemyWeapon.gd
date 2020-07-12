extends MeshInstance
class_name EnemyWeapon

export(PackedScene) var bulletPackedScene: PackedScene
export(NodePath) var lightNodePath: NodePath
onready var light: OmniLight = get_node(lightNodePath)

var shootInterval := 1
var time := 0.0

func _ready() -> void:
	randomize()
	GameManager.connect("stageChanged", self, "_onStageChanged")

func _physics_process(delta: float) -> void:
	if !visible: return
	time += delta
	if time > shootInterval:
		shootInterval = randi() % 10
		time = 0
		var bullet: Bullet = bulletPackedScene.instance()
		bullet.color = light.light_color
		bullet.set_as_toplevel(true)
		$BulletSpawnPoint.add_child(bullet)

func _onStageChanged(stage: int) -> void:
	if stage >= GameManager.Stage.SHOOT:
		yield(get_tree().create_timer(5), "timeout")
		visible = true
