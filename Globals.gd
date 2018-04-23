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
    "Sonar Room",
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

const CREW_NAMES_POOL = [
    "John",
    "James",
    "Dan",
    "Jamie",
    "Aidan",
    "Carol",
    "Caspar",
    "Rhys",
    "Carys",
    "Alex",
    "Michael"
]

const GREETING_MESSAGES = [
    "Yes, captain?",
    "Hmm?",
    "What can I do you for captain?",
    "Need anything? We're all a bit busy around here you know!",
    "How can I help, captain?",
]

const BUGGER_OFF_MESSAGES = [
    "Bugger off!",
    "Sorry, too busy to talk; you do know that the boat's on fire right?",
    "Haven't you harrassed me enough already?",
    "Too busy!",
]

const MAYBE_THIS_PERSON_MESSAGES = [
    "I wasn't with them at the time, so I can't say.",
    "I don't know what they were doing at the time.",
    "I know nothing!",
    "No clue.",
]

const NOT_THIS_PERSON_MESSAGES = [
    "It can't be him... I was with him at the time.",
    "It wasn't him; I was on watch with him at the time.",
]

const MAYBE_THIS_PLACE_MESSAGES = [
    "I wasn't there at the time, so I can't say.",
    "I know nothing!",
    "No clue.",
]

const NOT_THIS_PLACE_MESSAGES = [
    "It can't have happened there; I was working in there at the time.",
    "That's my chill-out spot - I would have seen if something happened!",
    "I was on watch in the %s, and nothing happened!",
]

const CASE_CLOSED_MESSAGES = [
    "Well I never! %s turned on the afterburner from the engine room while we were hiding in the enemy port.",
    "Well done! %s transmitted our location to the enemy by hacking the sonar to broadcast it using morse code!",
    "Who would have guessed? %s set off the New Year party fireworks from weapon control in a display that could be seen clear from the enemy harbour.",
    "You got it! %s wrote our location on a postcard and fired it at the enemy from the torpedo room.",
    "Superb detective work. It wasn't an accident when the life support broke last week; it was %s who used the distraction to compromise our position.",
    "Case closed. %s pumped dye into the sea from the pump room leaving a trail for the enemy to follow.",
    "What on earth?! %s implanted trackers in the captain's pet pigeon and let it escape.",
    "You figured it out! %s leaked our position by launching a carrier pigeon off the periscope from the bridge.",
]

# Global vars for the win screen
var win_text = ""


# Detective settings
const ROOM_KNOWLEDGE_COUNT = 8
const TRAITOR_KNOWLEDGE_COUNT = 8

# Player settings

const PLAYER_JUMP_SPEED = 200
const PLAYER_JUMP_MAX_AIRBORNE_TIME = 0.2

const PLAYER_WALK_SPEED = 200
const PLAYER_CLIMB_SPEED = 200

# Crewman settings
const CREW_SPEED = 150
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
const SUB_FIRE_DAMAGE_RATE = 0.4
