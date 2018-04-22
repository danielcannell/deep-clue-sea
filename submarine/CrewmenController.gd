extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var crewmen = []
var selected_crewman = null

func _ready():
    crewmen = get_children()
    
    for c in crewmen:
        c.connect("clicked", self, "crewman_clicked")

#func _process(delta):
#    # Called every frame. Delta is time since last frame.
#    # Update game logic here.
#    pass

func crewman_clicked(c):
    if selected_crewman:
        selected_crewman.deselect()
    selected_crewman = c
    selected_crewman.select()

func command_to_room(room):
    if selected_crewman:
        selected_crewman.command_to_room(room)
