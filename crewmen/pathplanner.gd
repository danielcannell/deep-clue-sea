extends Node

var Rooms = null
var roommapping = null
var roomunmapping = null
const roomgraph = [
    # Left room
    [2],
    # Left ladder top
    [2,4],
    # Left ladder middle
    [0,1,3,6],
    # Left ladder bottom
    [2,8],
    # Top left room
    [1,5],
    # Top right room
    [4,10],
    # Middle left room
    [2,7],
    # Middle right room
    [6,11],
    # Bottom left room
    [3,9],
    # Bottom right room
    [8,12],
    # Right ladder top
    [5,11],
    # Right ladder middle
    [7,10,12,13],
    # Right ladder bottom
    [9,11],
    # Right room
    [11]
]

var submarine = null

class GNode:
    var id = 0
    var dist = INF
    var prev = null

class PathResult:
    var path = []
    var dist = INF

func _ready():
    submarine = get_node("/root/Main/Submarine")
    Rooms = Globals.Rooms
    roommapping = {
        Rooms.EngineRoom: 0,
        Rooms.Instrumentation: 5,
        Rooms.WeaponControl: 7,
        Rooms.TorpedoBay: 9,
        Rooms.LifeSupport: 4,
        Rooms.PumpRoom: 6,
        Rooms.MedBay: 8,
        Rooms.Bridge: 13,
    
        Rooms.UpperLeftLadder: 1,
        Rooms.MiddleLeftLadder: 2,
        Rooms.LowerLeftLadder: 3,
    
        Rooms.UpperRightLadder: 10,
        Rooms.MiddleRightLadder: 11,
        Rooms.LowerRightLadder: 12,
    }
    roomunmapping = {
        0: Rooms.EngineRoom,
        1: Rooms.UpperLeftLadder,
        2: Rooms.MiddleLeftLadder,
        3: Rooms.LowerLeftLadder,
        4: Rooms.LifeSupport,
        5: Rooms.Instrumentation,
        6: Rooms.PumpRoom,
        7: Rooms.WeaponControl,
        8: Rooms.MedBay,
        9: Rooms.TorpedoBay,
        10: Rooms.UpperRightLadder,
        11: Rooms.MiddleRightLadder,
        12: Rooms.LowerRightLadder,
        13: Rooms.Bridge,
    }

func get_room_from_graph(gid):
    var rid = roomunmapping[gid]
    return submarine.room(rid)

func get_graph_from_room_id(rid):
    return roommapping[rid]

func get_length(u, v):
    var room = get_room_from_graph(v)
    var fire = room.fire()
    var flooding = room.flooding()
    var cost = 0
    if flooding > 0.0:
        cost = 10 * flooding
    elif fire > 0.0:
        cost = 30 * fire
    return 1 + cost

func dijkstra(graph, start_room, end_room):
    var s = get_graph_from_room_id(start_room)
    var e = get_graph_from_room_id(end_room)

    var numnodes = graph.size()
    var nodes = []
    var queue = []
    for i in range(numnodes):
        var g = GNode.new()
        g.id = i
        nodes.append(g)
        queue.append(g)

    nodes[s].dist = 0

    while queue.size() > 0:
        # Get node with min dist in queue
        var i = 0
        var mindist = INF
        for x in range(queue.size()):
            var d = queue[x].dist
            if d < mindist:
                mindist = d
                i = x
        var snode = queue[i]

        # If the target was the shortest, we're done
        if snode.id == e:
            break

        # Remove that node from queue
        queue.remove(i)

        # For each neighbour of that node
        for nid in graph[snode.id]:
            var nnode = nodes[nid]
            # Compute the new distance to that neighbour via snode
            var alt = snode.dist + get_length(snode.id, nid)
            if alt < nnode.dist:
                nnode.dist = alt
                nnode.prev = snode.id

    var pr = PathResult.new()
    var u = e
    pr.dist = nodes[u].dist
    if pr.dist < INF:
        while nodes[u].prev != null:
            pr.path.push_front(u)
            u = nodes[u].prev
        pr.path.push_front(u)
    return pr

# pos: Vector2D
# endpos: Vector2D
func get_path_vector(pos, endpos):
    # Get room ids
    var start_room_id = submarine.containing_room_id(pos)
    var end_room_id = submarine.containing_room_id(endpos)
    # Run shortest-path algorithm on graph
    var pr = dijkstra(roomgraph, start_room_id, end_room_id)

    # If there is no path, return 0
    if pr.dist == INF:
        return Vector2(0,0)

    var path = pr.path

    # If we're in the goal room, return a vector to the room center
    if get_graph_from_room_id(end_room_id) == path[0]:
        return endpos - pos

    # Work out which direction we should head in
    var next_room_pos = get_room_from_graph(path[1]).centre_position()
    var current_room_pos = get_room_from_graph(path[0]).centre_position()
    # Direction from current pos to current room center
    var offset_from_current = current_room_pos - pos
    # Direction from current room center to next room center
    var current_to_next = next_room_pos - current_room_pos

    var angle_ish = offset_from_current.angle_to(current_to_next)
    var on_line_ish = abs(angle_ish) < 0.1 or abs(angle_ish) > (PI - 0.1)

    if on_line_ish:
        return next_room_pos - pos
    else:
        return current_room_pos - pos