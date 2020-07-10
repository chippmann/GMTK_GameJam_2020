extends Reference
class_name Logger


static func debug(var message, var printStackTrace: bool = false) -> void:
	if !OS.is_debug_build(): return
	print(_assembleMessage("DEBUG: ", message))
	if printStackTrace:
		print_stack()


static func info(var message, var printStackTrace: bool = false) -> void:
	print(_assembleMessage("INFO: ", message))
	if printStackTrace:
		print_stack()


static func warning(var message, var printStackTrace: bool = false) -> void:
	print(_assembleMessage("WARNING: ", message))
	if printStackTrace:
		print_stack()


static func error(var message, var printStackTrace: bool = false, var shouldThrow: bool = false) -> void:
	printerr(_assembleMessage("ERROR: ", message))
	if printStackTrace:
		print_stack()
	if shouldThrow:
		var zeroDivider: int = 0
		1 / zeroDivider #throws DividedByZero exception


static func _assembleMessage(var tag: String, var message) -> String:
	var atString := ""
	if OS.is_debug_build():
		var stack: Array = get_stack() #[{function:bar, line:12, source:res://script.gd}, {function:foo, line:9, source:res://script.gd}, {function:_ready, line:6, source:res://script.gd}]
		var lineOfInterest: Dictionary = stack[2] #0 is here, 1 is debug method, 2 is actuall call place of user
		atString = "\n	at %s:%s:%s()" % [lineOfInterest["source"], lineOfInterest["line"], lineOfInterest["function"]]
	
	var formattedMessage: String = tag
	
	if message is Array:
		formattedMessage += "["
		for item in message:
			formattedMessage += _formatMessage(item)
		formattedMessage += "]"
	else:
		formattedMessage += _formatMessage(message)
	
	if OS.is_debug_build():
		formattedMessage += atString
	
	return formattedMessage


static func _formatMessage(var message) -> String:
	if message is Object && message.has_method("toString"):
		return message.toString()
	else:
		return str(message)
