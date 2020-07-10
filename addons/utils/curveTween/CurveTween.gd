extends Tween
class_name CurveTween

signal curve_tween(saturation)

export(Curve) var curve: Curve

var start = 0.0 #dynamic type
var end = 0.0 #dynamic type


"""
takes three parameters:
		duration: 	how long to interpolate for
		startIn:		the starting value
		endIn:		the ending value
interpolation begins immediately
interpolation follows the curve provided
"""
func play(var duration: float, var startIn = 0.0, var endIn = 1.0) -> void:
	assert(curve, "This CurveTween needs a curve added in the inspector")
	start = startIn
	end = endIn
	interpolate_method(self, "interpolate", 0.0, 1.0, duration, Tween.TRANS_LINEAR, Tween.EASE_IN)
	start()


func interpolate(var saturation) -> void:
	emit_signal("curve_tween", start + ((end - start) * curve.interpolate(saturation)))
