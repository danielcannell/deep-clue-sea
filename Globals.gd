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