extends Node2D

const BURN_DAMAGE = 0.5

var hitpoints = 100

signal dead
signal hitpoints_update

func _init():
    pass

func _ready():
    for rm in Globals.ROOMS_LIST:
        room(rm).set_name(Globals.ROOM_NAMES[rm])

    var controller = get_node("CrewmenController")
    for rm in Globals.ROOMS_LIST:
        room(rm).connect("clicked", controller, "command_to_room")

func _process(delta):
    if hitpoints > 0.0:
        # Environmental damage from fires
        for roomid in Globals.ROOMS_LIST:
            var r = room(roomid)
            if r.fire() > 0.0:
                hitpoints -= BURN_DAMAGE * delta

        emit_signal("hitpoints_update", hitpoints)

        if hitpoints <= 0:
            emit_signal("dead")

func room(room_id):
    match room_id:
        Globals.Rooms.EngineRoom:        return get_node("TileMap/EngineRoom")
        Globals.Rooms.Instrumentation:   return get_node("TileMap/Instrumentation")
        Globals.Rooms.WeaponControl:     return get_node("TileMap/WeaponControl")
        Globals.Rooms.TorpedoBay:        return get_node("TileMap/TorpedoBay")
        Globals.Rooms.LifeSupport:       return get_node("TileMap/LifeSupport")
        Globals.Rooms.PumpRoom:          return get_node("TileMap/PumpRoom")
        Globals.Rooms.MedBay:            return get_node("TileMap/MedBay")
        Globals.Rooms.Bridge:            return get_node("TileMap/Bridge")

        Globals.Rooms.UpperLeftLadder:   return get_node("TileMap/UpperLeftLadder")
        Globals.Rooms.MiddleLeftLadder:  return get_node("TileMap/MiddleLeftLadder")
        Globals.Rooms.LowerLeftLadder:   return get_node("TileMap/LowerLeftLadder")
        Globals.Rooms.UpperRightLadder:  return get_node("TileMap/UpperRightLadder")
        Globals.Rooms.MiddleRightLadder: return get_node("TileMap/MiddleRightLadder")
        Globals.Rooms.LowerRightLadder:  return get_node("TileMap/LowerRightLadder")

func containing_room_id(pos):
    for rm in Globals.ROOMS_LIST:
        if room(rm).contains(pos):
            return rm

    for ld in Globals.LADDERS_LIST:
        if room(ld).contains(pos):
            return ld
