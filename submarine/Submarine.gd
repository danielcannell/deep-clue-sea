extends Node2D

func _init():
    pass

func _ready():
    room(Globals.Rooms.EngineRoom).set_id(Globals.Rooms.EngineRoom)
    room(Globals.Rooms.Instrumentation).set_id(Globals.Rooms.Instrumentation)
    room(Globals.Rooms.WeaponControl).set_id(Globals.Rooms.WeaponControl)
    room(Globals.Rooms.TorpedoBay).set_id(Globals.Rooms.TorpedoBay)
    room(Globals.Rooms.LifeSupport).set_id(Globals.Rooms.LifeSupport)
    room(Globals.Rooms.PumpRoom).set_id(Globals.Rooms.PumpRoom)
    room(Globals.Rooms.MedBay).set_id(Globals.Rooms.MedBay)
    room(Globals.Rooms.Bridge).set_id(Globals.Rooms.Bridge)
    
    for rm in Globals.ROOMS_LIST:
        room(rm).connect("clicked", self, "room_clicked")

func _process(delta):
    # Called every frame. Delta is time since last frame.
    # Update game logic here.
    pass

func room_clicked(id):
    print("Clicked ", id, " ", room(id).centre_position())

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
