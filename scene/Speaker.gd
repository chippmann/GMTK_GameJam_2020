extends StaticBody
class_name Speaker

var nextColorChange := 0.0

var lightColor = _getLightColor()


func _process(delta: float) -> void:
	if nextColorChange < OS.get_ticks_msec():
		nextColorChange = OS.get_ticks_msec() + 1000
		lightColor = _getLightColor()
	
	
	var energy = SoundPlayer.speakerSpectrumEnergy
	$GlowSmall/OmniLight.light_energy = energy * 64
	$GlowBig/OmniLight.light_energy = energy * 64
	
	var material := SpatialMaterial.new()
	material.emission_enabled = true
	material.albedo_color = Color.black
	material.emission_energy = 8
	material.emission = lightColor
	
	$GlowSmall.material_override = material
	$GlowBig.material_override = material
	$GlowSmall/OmniLight.light_color = lightColor
	$GlowBig/OmniLight.light_color = lightColor


func _getLightColor() -> Color:
	return Color(randf(), randf(), randf())


