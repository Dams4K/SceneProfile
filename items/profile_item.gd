@abstract
extends Resource
class_name ProfileItem

var interpretor: SceneProfileInterpretor : set = set_interpretor

@abstract func apply(quality: Presets.Quality) -> void


func set_interpretor(value: SceneProfileInterpretor) -> void:
	interpretor = value
