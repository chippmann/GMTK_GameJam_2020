extends MeshInstance
class_name Weapon

export(PackedScene) var bulletPackedScene: PackedScene
export(NodePath) var lightNodePath: NodePath
onready var light: OmniLight = get_node(lightNodePath)

func _physics_process(delta: float) -> void:
	visible = GameManager.currentStage >= GameManager.Stage.SHOOT
	if !visible: return
	if Input.is_action_just_pressed("shoot"):
		var bullet: Bullet = bulletPackedScene.instance()
		bullet.color = light.light_color
		bullet.set_as_toplevel(true)
		$BulletSpawnPoint.add_child(bullet)
