# Get the edge (The deepest projection is the max)
$scoreboard players operation #Physics.Projection.OtherObjectCorner$(StartCorner0).CrossProductAxis.z$(Axis) Physics /= #Physics.Constants.1000 Physics
$execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner$(StartCorner0).CrossProductAxis.z$(Axis) Physics run return run function physics:zprivate/contact_generation/new_contact/object/edge_edge/this_axis_z/get_edge_b_$(Axis) with storage physics:temp data.ObjectEdge.$(Axis)[0]

$scoreboard players operation #Physics.Projection.OtherObjectCorner$(StartCorner1).CrossProductAxis.z$(Axis) Physics /= #Physics.Constants.1000 Physics
$execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner$(StartCorner1).CrossProductAxis.z$(Axis) Physics run return run function physics:zprivate/contact_generation/new_contact/object/edge_edge/this_axis_z/get_edge_b_$(Axis) with storage physics:temp data.ObjectEdge.$(Axis)[1]

$scoreboard players operation #Physics.Projection.OtherObjectCorner$(StartCorner2).CrossProductAxis.z$(Axis) Physics /= #Physics.Constants.1000 Physics
$execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner$(StartCorner2).CrossProductAxis.z$(Axis) Physics run return run function physics:zprivate/contact_generation/new_contact/object/edge_edge/this_axis_z/get_edge_b_$(Axis) with storage physics:temp data.ObjectEdge.$(Axis)[2]

$scoreboard players operation #Physics.Projection.OtherObjectCorner$(StartCorner3).CrossProductAxis.z$(Axis) Physics /= #Physics.Constants.1000 Physics
$function physics:zprivate/contact_generation/new_contact/object/edge_edge/this_axis_z/get_edge_b_$(Axis) with storage physics:temp data.ObjectEdge.$(Axis)[3]
