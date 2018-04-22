extends Area2D

const BURN_RATE = 0.01
const FLOOD_RATE = 0.01

const EXTINGUISH_RATE = 0.02
const DRAIN_RATE = 0.02

var m_fire = 0.0
var m_flooding = 0.0
var m_id = null

signal clicked(id)

func _ready():
    pass

func _process(delta):
    if m_fire > 0.0:
        m_fire = min(m_fire + BURN_RATE * delta, 1)
    if m_flooding > 0.0:
        m_flooding = min(m_flooding + FLOOD_RATE * delta, 1)

    var fire_scale = 0
    if m_fire > 0.0:
        fire_scale = 0.3 + (m_fire * 0.7)
    get_node("Fire").set_scale(Vector2(fire_scale, fire_scale))

    var flood_scale = 0
    if m_flooding > 0.0:
        flood_scale = 0.1 + (m_flooding * 0.9)
    get_node("Flood").set_scale(Vector2(1, flood_scale))

func _input_event(viewport, event, shape_idx):
    if event is InputEventMouseButton:
        if event.button_index == BUTTON_LEFT and event.pressed:
            emit_signal("clicked", m_id)

func id():
    return m_id

func set_id(id):
    m_id = id

func start_fire():
    if m_fire <= 0.0 and m_flooding <= 0.0:
        m_fire = BURN_RATE
    
func start_flooding():
    m_fire = 0.0
    if m_flooding <= 0.0:
        m_flooding = FLOOD_RATE

func extinguish_fire():
    m_fire -= EXTINGUISH_RATE
    if m_fire < 0.0:
        m_fire = 0.0
        return true

func drain_flooding():
    m_flooding -= DRAIN_RATE
    if m_flooding < 0.0:
        m_flooding = 0.0
        return true

func fire():
    return m_fire
    
func flooding():
    return m_flooding

func centre_position():
    var extents = get_node("CollisionShape2D").shape.extents
    return position + extents.y - 4
    
func contains(pos):
    var epsilon = 5
    var extents = get_node("CollisionShape2D").shape.extents
    
    return (
        pos.x + epsilon >= position.x - extents.x and
        pos.x - epsilon <= position.x + extents.x and
        pos.y + epsilon >= position.y - extents.y and
        pos.y - epsilon <= position.y + extents.y)
