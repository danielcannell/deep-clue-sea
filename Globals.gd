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

const ROOM_KNOWLEDGE_COUNT = 2
const TRAITOR_KNOWLEDGE_COUNT = 2

# Crewman settings
const CREW_SPEED = 200
const HEALING_RATE = 10
const FIRE_DAMAGE_RATE = 20
const DROWNING_DAMAGE_RATE = 10
const FLOODED_MAX_SPEED = 0.25
const CREW_MAX_HITPOINTS = 100