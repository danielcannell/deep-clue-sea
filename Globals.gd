extends Node

enum Rooms {
    EngineRoom,
    Instrumentation,
    WeaponControl,
    TorpedoBay,
    LifeSupport,
    PumpRoom,
    MedBay,
    Bridge,

    UpperLeftLadder,
    MiddleLeftLadder,
    LowerLeftLadder,

    UpperRightLadder,
    MiddleRightLadder,
    LowerRightLadder,
}

const ROOM_NAMES = [
    "Engine Room",
    "Instrumentation",
    "Weapon Control",
    "Torpedo Bay",
    "Life Support",
    "Pump Room",
    "Med Bay",
    "Bridge",
]

const ROOMS_LIST = [
    Rooms.EngineRoom,
    Rooms.Instrumentation,
    Rooms.WeaponControl,
    Rooms.TorpedoBay,
    Rooms.LifeSupport,
    Rooms.PumpRoom,
    Rooms.MedBay,
    Rooms.Bridge
]

const LADDERS_LIST = [
    Rooms.UpperLeftLadder,
    Rooms.MiddleLeftLadder,
    Rooms.LowerLeftLadder,
    Rooms.UpperRightLadder,
    Rooms.MiddleRightLadder,
    Rooms.LowerRightLadder,
]