extends Area2D

var m_fire = 0.0
var m_flooding = 0.0

signal clicked(room)

func _ready():
    pass

func _process(delta):
    if m_fire > 0.0:
        m_fire = min(m_fire + Globals.ROOM_BURN_RATE * delta, 1)
    if m_flooding > 0.0:
        m_flooding = min(m_flooding + Globals.ROOM_FLOOD_RATE * delta, 1)

    var fire_scale = 0
    if m_fire > 0.0:
        fire_scale = 0.3 + (m_fire * 0.7)
    get_node("Fire").set_scale(Vector2(fire_scale, fire_scale))
    get_node("Fire").set_rotation(deg2rad(rand_range(-5, 5)))

    var flood_scale = 0
    if m_flooding > 0.0:
        flood_scale = 0.1 + (m_flooding * 0.9)
    get_node("Flood").set_scale(Vector2(1, flood_scale))

func _input_event(viewport, event, shape_idx):
    if event is InputEventMouseButton:
        if event.button_index == BUTTON_RIGHT and event.pressed:
            emit_signal("clicked", self)

func set_name(name):
    get_node("RoomName").set_text(name)

func start_fire():
    if m_fire <= 0.0 and m_flooding <= 0.0:
        m_fire = Globals.ROOM_BURN_RATE
    
func start_flooding():
    m_fire = 0.0
    if m_flooding <= 0.0:
        m_flooding = Globals.ROOM_FLOOD_RATE

func extinguish_fire(delta):
    m_fire -= Globals.FIRE_EXTINGUISH_RATE * delta
    if m_fire < 0.0:
        m_fire = 0.0
        return true

func drain_flooding(delta):
    m_flooding -= Globals.FLOOD_DRAIN_RATE * delta
    if m_flooding < 0.0:
        m_flooding = 0.0
        return true

func fire():
    return m_fire
    
func flooding():
    return m_flooding

func centre_position():
    var extents = get_node("CollisionShape2D").shape.extents
    return position + Vector2(0, extents.y - 4)
    
func contains(pos):
    var epsilon = 5
    var extents = get_node("CollisionShape2D").shape.extents
    
    return (
        pos.x + epsilon >= position.x - extents.x and
        pos.x - epsilon <= position.x + extents.x and
        pos.y + epsilon >= position.y - extents.y and
        pos.y - epsilon <= position.y + extents.y)
