extends Node

const FREQ_MAX := 11050.0
const MIN_DB := 60


export(NodePath) var audioStreamPlayerNodePath
onready var audioStreamPlayer: AudioStreamPlayer = get_node(audioStreamPlayerNodePath)

export(Array, AudioStream) var audioStreams: Array

onready var busIndex := AudioServer.get_bus_index(audioStreamPlayer.bus)
onready var spectrumAnalyzer: AudioEffectSpectrumAnalyzerInstance = AudioServer.get_bus_effect_instance(busIndex, 0)

const _spectrumToMeasureCount := 16
var wholeSpectrumEnergy: float = 0
var spectrumEnergy: Array = Array()

func _ready() -> void:
	spectrumEnergy.resize(_spectrumToMeasureCount)
	audioStreamPlayer.stream = audioStreams[0]
	audioStreamPlayer.play()

func _process(_delta: float) -> void:
	var wholeSpectrumMagnitude := spectrumAnalyzer.get_magnitude_for_frequency_range(0, FREQ_MAX).length()
	wholeSpectrumEnergy = clamp((MIN_DB + linear2db(wholeSpectrumMagnitude)) / MIN_DB, 0, 1)
	
	var peviousHz: float = 0
	for i in range(1, _spectrumToMeasureCount + 1):
		var hz := i * FREQ_MAX / _spectrumToMeasureCount;
		var magnitude := spectrumAnalyzer.get_magnitude_for_frequency_range(peviousHz, hz).length()
		var energy = clamp((MIN_DB + linear2db(magnitude)) / MIN_DB, 0, 1)
		spectrumEnergy.insert(i, energy)
		peviousHz = hz


func changeToStage(stage: int) -> void:
	audioStreamPlayer.stop()
	audioStreamPlayer.stream = audioStreams[stage]
	audioStreamPlayer.play()
