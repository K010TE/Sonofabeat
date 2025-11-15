extends Node

@export var bpm: float = 120.0

var beat_interval: float
var time_accumulator: float = 0.0

signal beat

func _ready() -> void:
	beat_interval = 60.0 / bpm
	print("BPMManager ready. BPM =", bpm, " | Beat interval =", beat_interval)

func _process(delta: float) -> void:
	time_accumulator += delta
	while time_accumulator >= beat_interval:
		time_accumulator -= beat_interval
		emit_signal("beat")
		print("BEAT")
