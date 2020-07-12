extends Node

const FREQ_MAX := 11050.0
const MIN_DB := 60


export(NodePath) var audioStreamPlayerNodePath
onready var audioStreamPlayer: AudioStreamPlayer = get_node(audioStreamPlayerNodePath)

export(Array, AudioStream) var audioStreams: Array
export(Array, AudioStream) var intros: Array

onready var busIndex := AudioServer.get_bus_index(audioStreamPlayer.bus)
onready var spectrumAnalyzer: AudioEffectSpectrumAnalyzerInstance = AudioServer.get_bus_effect_instance(busIndex, 0)

const _spectrumToMeasureCount := 16
var wholeSpectrumEnergy: float = 0
var spectrumEnergy: Array = [0]
var speakerSpectrumEnergy: float = 0
var speakerOverdriveSpectrumEnergy: float = 0

func _ready() -> void:
	audioStreamPlayer.connect("finished", self, "_onAudioPlayerFinished")
	spectrumEnergy.resize(_spectrumToMeasureCount)
	audioStreamPlayer.stream = audioStreams[0]
	audioStreamPlayer.play()

func _process(_delta: float) -> void:
	var wholeSpectrumMagnitude := spectrumAnalyzer.get_magnitude_for_frequency_range(0, FREQ_MAX).length()
	wholeSpectrumEnergy = clamp((MIN_DB + linear2db(wholeSpectrumMagnitude)) / MIN_DB, 0, 1)
	
	var speakerSpectrumMagnitude := spectrumAnalyzer.get_magnitude_for_frequency_range(0, 65).length()
	speakerSpectrumEnergy = clamp((MIN_DB + linear2db(speakerSpectrumMagnitude)) / MIN_DB, 0, 1)
	
	var speakerOverdriveSpectrumMagnitude := spectrumAnalyzer.get_magnitude_for_frequency_range(0, 35).length()
	speakerOverdriveSpectrumEnergy = clamp((MIN_DB + linear2db(speakerOverdriveSpectrumMagnitude)) / MIN_DB, 0, 1)
	
	var peviousHz: float = 0
	for i in range(1, _spectrumToMeasureCount + 1):
		var hz := i * FREQ_MAX / _spectrumToMeasureCount;
		var magnitude := spectrumAnalyzer.get_magnitude_for_frequency_range(peviousHz, hz).length()
		var energy = clamp((MIN_DB + linear2db(magnitude)) / MIN_DB, 0, 1)
		spectrumEnergy.insert(i, energy)
		peviousHz = hz


func changeToStage(stage: int) -> void:
	if !audioStreamPlayer: return
	if stage > intros.size() - 1: return
	audioStreamPlayer.stop()
	if intros[stage]:
		audioStreamPlayer.stream = intros[stage]
		audioStreamPlayer.play()
		yield(audioStreamPlayer, "finished")
	
	audioStreamPlayer.stream = audioStreams[stage]
	audioStreamPlayer.play()


func _onAudioPlayerFinished() -> void:
	if GameManager.currentStage == GameManager.Stage.SHOOT:
		return
	
	GameManager.musicFinished()
