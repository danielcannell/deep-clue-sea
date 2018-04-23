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


# Global vars for the win screen
var win_text = ""


# Detective settings
const ROOM_KNOWLEDGE_COUNT = 2
const TRAITOR_KNOWLEDGE_COUNT = 2

# Player settings

const PLAYER_JUMP_SPEED = 200
const PLAYER_JUMP_MAX_AIRBORNE_TIME = 0.2

const PLAYER_WALK_SPEED = 200
const PLAYER_CLIMB_SPEED = 200

# Crewman settings
const CREW_SPEED = 200
const FLOODED_MAX_SPEED = 0.25
const HEALING_RATE = 10

const FIRE_DAMAGE_RATE = 5

const ROOM_FLOODING_DROWNING_LIMIT = 0.7
const DROWNING_DAMAGE_RATE = 10

const CREW_MAX_HITPOINTS = 25

const INTERACTRION_DISTANCE = 40
const BUGGER_OFF_TIME = 10

const IDLE_TIME_MIN = 1
const IDLE_TIME_MAX = 5


# Environment settings
const GRAVITY = 1000.0 # pixels/second/second

const DISASTER_PERCENTAGE_PER_SECOND = 40
const FIRE_PERCENTAGE = 80 # Floods are the complement of this

const ROOM_BURN_RATE = 0.2
const ROOM_FLOOD_RATE = 0.1

const FIRE_EXTINGUISH_RATE = 1.0
const FLOOD_DRAIN_RATE = 0.3

const SUB_MAX_HITPOINTS = 100
const SUB_FIRE_DAMAGE_RATE = 0.05