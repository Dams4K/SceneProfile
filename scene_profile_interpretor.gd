@tool
extends Node
class_name SceneProfileInterpretor

enum Presets {
	LOW,
	MEDIUM,
	HIGH,
	ULTRA
}

static var instance: SceneProfileInterpretor

@export var editor_preset := Presets.MEDIUM

@export var items: Array[ProfileItem] = []

func _ready() -> void:
	instance = self
