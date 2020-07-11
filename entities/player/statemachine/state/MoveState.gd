extends State3D
class_name MoveState

const _sprintMultiplier := 2

func physicsProcess(delta: float) -> void:
	var parentState := _getTypedParentState()
	if !parentState.hasMovementInput():
		_getStatemachine().transitionTo(_getStatemachine().idleState)
		return
	
	parentState._inputVelocity.z = (Input.get_action_strength("movement_backward") - Input.get_action_strength("movement_forward")) * parentState.movementSpeed * parentState._movementMultiplicator
	parentState._inputVelocity.x = (Input.get_action_strength("movement_right") - Input.get_action_strength("movement_left")) * parentState.movementSpeed * parentState._movementMultiplicator
	
	if InputUtils.isMovingDiagonally(parentState._velocity):
		parentState._inputVelocity /= sqrt(PI)
	
	if Input.is_action_pressed("movement_sprint"):
		parentState._inputVelocity *= _sprintMultiplier
	
	parentState.physicsProcess(delta)


func _getTypedParentState() -> MovementState:
	return _parentState as MovementState


func _getStatemachine() -> PlayerStateMachine:
	return _stateMachine as PlayerStateMachine
