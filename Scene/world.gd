extends Node2D


const LIGHT_TEXTURE = preload("res://Assets/Light.png")
const GRID_SIZE = 16

@onready var fog = $fog

var display_width = ProjectSettings.get("display/window/size/window_width_override")
var display_height = ProjectSettings.get("display/window/size/window_height_override")

var fogImage = Image.new()
var fogTexture = ImageTexture.new()
var lightImage = LIGHT_TEXTURE.get_image()
var light_offset = Vector2(LIGHT_TEXTURE.get_width()/2,LIGHT_TEXTURE.get_height()/2)



func _ready() -> void:
    print(display_width)
    var fog_image_width = display_width/GRID_SIZE
    var fog_image_height = display_height/GRID_SIZE
    fogImage = Image.create(fog_image_width,fog_image_height,false,Image.FORMAT_RGBAH)
    # fogImage.create(fog_image_width,fog_image_height,false,Image.FORMAT_RGBAH)
    fogImage.fill(Color.BLACK)
    lightImage.convert(Image.FORMAT_RGBAH)
    fog.scale *= GRID_SIZE

func update_fog(new_grid_positon):
    # fogImage.lock()
    # lightImage.lock()

    var light_rect = Rect2(Vector2.ZERO, Vector2(lightImage.get_width(),lightImage.get_height()))
    fogImage.blend_rect(lightImage,light_rect,new_grid_positon - light_offset)

    # fogImage.unlock()
    # lightImage.unlock()
    update_fog_image_texture()

func update_fog_image_texture():
    fogTexture = ImageTexture.create_from_image(fogImage)
    fog.texture = fogTexture

# func _input(event: InputEvent) -> void:
func _process(delta: float) -> void:
    update_fog(get_local_mouse_position()/GRID_SIZE)
    pass
