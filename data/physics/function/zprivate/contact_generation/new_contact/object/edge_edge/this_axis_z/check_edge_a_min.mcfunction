# Get the edge (The deepest projection is the min)
$scoreboard players operation #Physics.Projection.ObjectCorner$(StartCorner0).CrossProductAxis.z$(Axis) Physics /= #Physics.Constants.1000 Physics
$execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner$(StartCorner0).CrossProductAxis.z$(Axis) Physics run return run function physics:zprivate/contact_generation/new_contact/object/edge_edge/this_axis_z/get_edge_a_$(Axis) with storage physics:temp data.ObjectEdge.z[3]

$scoreboard players operation #Physics.Projection.ObjectCorner$(StartCorner1).CrossProductAxis.z$(Axis) Physics /= #Physics.Constants.1000 Physics
$execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner$(StartCorner1).CrossProductAxis.z$(Axis) Physics run return run function physics:zprivate/contact_generation/new_contact/object/edge_edge/this_axis_z/get_edge_a_$(Axis) with storage physics:temp data.ObjectEdge.z[2]

$scoreboard players operation #Physics.Projection.ObjectCorner$(StartCorner2).CrossProductAxis.z$(Axis) Physics /= #Physics.Constants.1000 Physics
$execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner$(StartCorner2).CrossProductAxis.z$(Axis) Physics run return run function physics:zprivate/contact_generation/new_contact/object/edge_edge/this_axis_z/get_edge_a_$(Axis) with storage physics:temp data.ObjectEdge.z[1]

$scoreboard players operation #Physics.Projection.ObjectCorner$(StartCorner3).CrossProductAxis.z$(Axis) Physics /= #Physics.Constants.1000 Physics
$function physics:zprivate/contact_generation/new_contact/object/edge_edge/this_axis_z/get_edge_a_$(Axis) with storage physics:temp data.ObjectEdge.z[0]
