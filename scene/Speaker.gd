extends StaticBody
class_name Speaker

var nextColorChange := 0.0

var lightColor = _getLightColor()

var isOverdriving := false
var player: Player = null

func _process(delta: float) -> void:
	if isOverdriving: return
	if nextColorChange < OS.get_ticks_msec():
		nextColorChange = OS.get_ticks_msec() + 1000
		lightColor = _getLightColor()
	
	
	var energy = SoundPlayer.speakerSpectrumEnergy if GameManager.currentStage < GameManager.Stage.SHOOT else SoundPlayer.speakerOverdriveSpectrumEnergy
	$GlowSmall/OmniLight.light_energy = energy * 64
	$GlowBig/OmniLight.light_energy = energy * 64
	
	var material := SpatialMaterial.new()
	material.emission_enabled = true
	material.albedo_color = Color.black
	material.emission_energy = energy * 8
	material.emission = lightColor
	
	$GlowSmall.material_override = material
	$GlowBig.material_override = material
	$GlowSmall/OmniLight.light_color = lightColor
	$GlowBig/OmniLight.light_color = lightColor


func _getLightColor() -> Color:
	return Color(randf(), randf(), randf())


func overDrive() -> void:
	isOverdriving = true
	var tween: Tween = $Tween
	
	tween.interpolate_property($GlowSmall/OmniLight, "light_energy", 0, 64, 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.interpolate_property($GlowBig/OmniLight, "light_energy", 0, 64, 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	var material := SpatialMaterial.new()
	material.emission_enabled = true
	material.albedo_color = Color.black
	tween.interpolate_property(material, "emission_energy", 0, 8, 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	material.emission = Color.red
	$GlowSmall.material_override = material
	$GlowBig.material_override = material
	$GlowSmall/OmniLight.light_color = Color.red
	$GlowBig/OmniLight.light_color = Color.red
	tween.start()
	yield(tween, "tween_all_completed")
	$GlowSmall/Particles.emitting = true
	$GlowBig/Particles2.emitting = true
	if player:
		player.damage(25, "If you listen music too loud you damage your ears...\nStay away from overdriving Speakers!")
	isOverdriving = false


func _on_Area_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player = body


func _on_Area_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player = null
