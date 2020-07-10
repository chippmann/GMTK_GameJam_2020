extends State3D
class_name MovementState

const _movementMultiplicator: int = 100

export(int) var movementSpeed := 10
export(NodePath) var kinematicBodyNodePath
onready var _kinematicBody: KinematicBody = get_node(kinematicBodyNodePath)

var _inputZ: Vector2 = Vector2.ZERO
var _inputX: Vector2 = Vector2.ZERO
var _inputVelocity: Vector3 = Vector3.ZERO
var _velocity: Vector3 = Vector3.ZERO


func unhandledInput(event: InputEvent) -> void:
	if !InputUtils.isMovementInput(event):
		return
	
	get_tree().set_input_as_handled()
	if event.is_action_pressed("movement_forward"):
		_inputZ.x = 1
	elif event.is_action_released("movement_forward"):
		_inputZ.x = 0
	
	if event.is_action_pressed("movement_backward"):
		_inputZ.y = 1
	elif event.is_action_released("movement_backward"):
		_inputZ.y = 0
	
	if event.is_action_pressed("movement_left"):
		_inputX.x = 1
	elif event.is_action_released("movement_left"):
		_inputX.x = 0
	
	if event.is_action_pressed("movement_right"):
		_inputX.y = 1
	elif event.is_action_released("movement_right"):
		_inputX.y = 0


func physicsProcess(delta: float) -> void:
	if hasMovementInput():
		_getStatemachine().transitionTo(_getStatemachine().moveState)
	elif _getStatemachine().currentState != $IdleState:
		_inputZ = Vector2.ZERO
		_inputX = Vector2.ZERO
		_getStatemachine().transitionTo(_getStatemachine().idleState)
		return
	
	_velocity = _kinematicBody.move_and_slide(_inputVelocity * delta, Vector3.UP)
	_inputVelocity = Vector3.ZERO


# false if we received released for all axis directions OR all axis directions return 0 strenght
# this covers the case when a GUI element consumes the release event of a axis direction or the game window looses focus
func hasMovementInput() -> bool:
	return (_inputZ != Vector2.ZERO && (Input.get_action_strength("movement_forward") != 0 || Input.get_action_strength("movement_backward") != 0)) \
			|| (_inputX != Vector2.ZERO && (Input.get_action_strength("movement_left") != 0 || Input.get_action_strength("movement_right") != 0))


func _getStatemachine() -> PlayerStateMachine:
	return _stateMachine as PlayerStateMachine
