extends Spatial
class_name Speakers

const speakerOverdriveInterval := 4
var time :float = 0

func _ready() -> void:
	randomize()

func _process(delta: float) -> void:
	if GameManager.currentStage >= GameManager.Stage.SURVIVAL:
		time += delta
		if time >= speakerOverdriveInterval:
			time -= speakerOverdriveInterval
			
			var speakers := get_children()
			var overdriveSpeakers = []
			
			for i in range(4):
				var index := randi() % speakers.size()
				overdriveSpeakers.append(speakers[index])
				speakers.remove(index)
			
			for speaker in overdriveSpeakers:
				speaker.overDrive()
