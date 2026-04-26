@abstract
extends Resource
class_name ProfileItem

var interpretor: SceneProfileInterpretor

@abstract func apply(preset: SceneProfileInterpretor.Presets) -> void
