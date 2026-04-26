@abstract
extends Resource
class_name ProfileItem

var interpretor: SceneProfileInterpretor : set = set_interpretor

@abstract func apply(preset: SceneProfileInterpretor.Presets) -> void


func set_interpretor(value: SceneProfileInterpretor) -> void:
	interpretor = value
