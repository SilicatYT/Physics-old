# Get the edge (The deepest projection is the min)
$scoreboard players operation #Physics.Projection.ObjectCorner$(StartCorner0).CrossProductAxis.x$(Axis) Physics /= #Physics.Constants.1000 Physics
$execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner$(StartCorner0).CrossProductAxis.x$(Axis) Physics run return run function physics:zprivate/contact_generation/new_contact/object/edge_edge/this_axis_x/get_edge_a_$(Axis) with storage physics:temp data.ObjectEdge.x[3]

$scoreboard players operation #Physics.Projection.ObjectCorner$(StartCorner1).CrossProductAxis.x$(Axis) Physics /= #Physics.Constants.1000 Physics
$execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner$(StartCorner1).CrossProductAxis.x$(Axis) Physics run return run function physics:zprivate/contact_generation/new_contact/object/edge_edge/this_axis_x/get_edge_a_$(Axis) with storage physics:temp data.ObjectEdge.x[2]

$scoreboard players operation #Physics.Projection.ObjectCorner$(StartCorner2).CrossProductAxis.x$(Axis) Physics /= #Physics.Constants.1000 Physics
$execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner$(StartCorner2).CrossProductAxis.x$(Axis) Physics run return run function physics:zprivate/contact_generation/new_contact/object/edge_edge/this_axis_x/get_edge_a_$(Axis) with storage physics:temp data.ObjectEdge.x[1]

$scoreboard players operation #Physics.Projection.ObjectCorner$(StartCorner3).CrossProductAxis.x$(Axis) Physics /= #Physics.Constants.1000 Physics
$function physics:zprivate/contact_generation/new_contact/object/edge_edge/this_axis_x/get_edge_a_$(Axis) with storage physics:temp data.ObjectEdge.x[0]
