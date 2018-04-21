extends Area2D

const BURN_RATE = 0.01
const FLOOD_RATE = 0.01

const EXTINGUISH_RATE = 0.02
const DRAIN_RATE = 0.02

var m_fire = 0.0
var m_flooding = 0.0
var m_id = null

func _ready():
    pass

func _process(delta):
    if m_fire > 0.0:
        m_fire += BURN_RATE
    if m_flooding > 0.0:
        m_flooding += FLOOD_RATE

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
    return Vector2()
