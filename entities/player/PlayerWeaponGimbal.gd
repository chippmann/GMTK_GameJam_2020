extends Spatial
class_name PlayerWeaponGimbal

var camera: Camera

func _ready() -> void:
	yield(get_parent(), "ready")
	camera = get_parent().get_node(get_parent().cameraNodePath)

func _process(delta: float) -> void:
	if !camera: return
	var ray_lenght = 1000
	var mouse_pos = get_viewport().get_mouse_position()
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_lenght
	var space_state = get_world().get_direct_space_state()
	# use global coordinates, not local to node
	var result = space_state.intersect_ray( from, to )
	var lookAt = Vector3(result.position.x, transform.origin.y, result.position.z)
	look_at(lookAt, Vector3.UP)
	rotation.x = 0
	$Weapon.look_at(lookAt, Vector3.UP)
	$Weapon.rotation.x = 0
