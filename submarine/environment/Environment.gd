extends Node

const TICK_TIME = 1
var time = 0

onready var NUMROOMS = len(Globals.ROOMS_LIST)
onready var submarine = get_node("/root/Main/Submarine")

func _ready():
    randomize()

func _process(delta):
    var disaster = false

    time += delta
    if time > TICK_TIME:
        time -= TICK_TIME
        disaster = rand_range(0, 100) < Globals.DISASTER_PERCENTAGE_PER_SECOND

    if disaster:
        var room_id = Globals.ROOMS_LIST[randi() % NUMROOMS]
        var affected_room = submarine.room(room_id)
        var is_fire = rand_range(0, 100) < Globals.FIRE_PERCENTAGE
        if is_fire or room_id == Globals.Rooms.PumpRoom:
            affected_room.start_fire()
        else:
            affected_room.start_flooding()
