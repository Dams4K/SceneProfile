@tool
extends Wrapper
class_name MainViewport

func get_obj() -> Variant:
	if Engine.is_editor_hint():
		return SceneProfilePluginHelper.get_editor_interface().get_editor_viewport_3d(0).get_viewport_rid()
	
	return (Engine.get_main_loop() as SceneTree).root.get_viewport().get_viewport_rid()
