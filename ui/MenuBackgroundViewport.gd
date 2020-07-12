extends Viewport
class_name MenuBackgroundViewport

onready var _parentViewport: Viewport = get_parent().get_viewport()

func _ready() -> void:
	var error = _parentViewport.connect("size_changed", self, "_onParentViewportSizeChanged")
	if error != OK:
		Logger.warning("Could not connect main menu resize signal! Background will not resize with the window now! Error was: %s" % ErrorConverter.toString(error))
	_onParentViewportSizeChanged()

func _onParentViewportSizeChanged() -> void:
	if _parentViewport:
		self.size = _parentViewport.size
