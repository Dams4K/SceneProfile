@tool
extends SingletonItem
class_name RenderingServerItem

func _init() -> void:
	singleton = "RenderingServer"

func apply(quality: Presets.Quality) -> void:
	super.apply(quality)
	RenderingServer.force_sync()
	RenderingServer.force_draw(false)
