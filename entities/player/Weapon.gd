extends MeshInstance
class_name Weapon

export(PackedScene) var bulletPackedScene: PackedScene
export(NodePath) var lightNodePath: NodePath
onready var light: OmniLight = get_node(lightNodePath)

func _ready() -> void:
	GameManager.connect("stageChanged", self, "_onStageChanged")

func _physics_process(delta: float) -> void:
	if !visible: return
	if Input.is_action_just_pressed("shoot"):
		var bullet: Bullet = bulletPackedScene.instance()
		bullet.color = light.light_color
		bullet.set_as_toplevel(true)
		$BulletSpawnPoint.add_child(bullet)


func _onStageChanged(stage: int) -> void:
	if stage >= GameManager.Stage.SHOOT:
		yield(get_tree().create_timer(5), "timeout")
		visible = true
