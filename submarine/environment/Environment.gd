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
        print("tick!")
        #disaster = rand_range(0, 10) < 1
        disaster = true

    if disaster:
        print("disaster")
        var room_id = Globals.ROOMS_LIST[randi() % NUMROOMS]
        var affected_room = submarine.room(room_id)
        var is_fire = rand_range(0, 100) < 80
        if is_fire or room_id == Globals.Rooms.PumpRoom:
            print("fire")
            affected_room.start_fire()
        else:
            print("flood")
            affected_room.start_flooding()
