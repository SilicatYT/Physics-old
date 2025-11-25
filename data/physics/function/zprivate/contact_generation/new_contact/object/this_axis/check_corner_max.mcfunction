# Get the corner (The deepest projection is the max)
$scoreboard players operation #Physics.Projection.OtherObjectCorner0.ObjectAxis.$(ObjectAxis) Physics /= #Physics.Constants.1000 Physics
$execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner0.ObjectAxis.$(ObjectAxis) Physics run return run function physics:zprivate/contact_generation/new_contact/object/this_axis/get_corner_$(ObjectAxis) {Corner:0b}

$scoreboard players operation #Physics.Projection.OtherObjectCorner1.ObjectAxis.$(ObjectAxis) Physics /= #Physics.Constants.1000 Physics
$execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner1.ObjectAxis.$(ObjectAxis) Physics run return run function physics:zprivate/contact_generation/new_contact/object/this_axis/get_corner_$(ObjectAxis) {Corner:1b}

$scoreboard players operation #Physics.Projection.OtherObjectCorner2.ObjectAxis.$(ObjectAxis) Physics /= #Physics.Constants.1000 Physics
$execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner2.ObjectAxis.$(ObjectAxis) Physics run return run function physics:zprivate/contact_generation/new_contact/object/this_axis/get_corner_$(ObjectAxis) {Corner:2b}

$scoreboard players operation #Physics.Projection.OtherObjectCorner3.ObjectAxis.$(ObjectAxis) Physics /= #Physics.Constants.1000 Physics
$execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner3.ObjectAxis.$(ObjectAxis) Physics run return run function physics:zprivate/contact_generation/new_contact/object/this_axis/get_corner_$(ObjectAxis) {Corner:3b}

$scoreboard players operation #Physics.Projection.OtherObjectCorner4.ObjectAxis.$(ObjectAxis) Physics /= #Physics.Constants.1000 Physics
$execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner4.ObjectAxis.$(ObjectAxis) Physics run return run function physics:zprivate/contact_generation/new_contact/object/this_axis/get_corner_$(ObjectAxis) {Corner:4b}

$scoreboard players operation #Physics.Projection.OtherObjectCorner5.ObjectAxis.$(ObjectAxis) Physics /= #Physics.Constants.1000 Physics
$execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner5.ObjectAxis.$(ObjectAxis) Physics run return run function physics:zprivate/contact_generation/new_contact/object/this_axis/get_corner_$(ObjectAxis) {Corner:5b}

$scoreboard players operation #Physics.Projection.OtherObjectCorner6.ObjectAxis.$(ObjectAxis) Physics /= #Physics.Constants.1000 Physics
$execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner6.ObjectAxis.$(ObjectAxis) Physics run return run function physics:zprivate/contact_generation/new_contact/object/this_axis/get_corner_$(ObjectAxis) {Corner:6b}

$scoreboard players operation #Physics.Projection.OtherObjectCorner7.ObjectAxis.$(ObjectAxis) Physics /= #Physics.Constants.1000 Physics
$function physics:zprivate/contact_generation/new_contact/object/this_axis/get_corner_$(ObjectAxis) {Corner:7b}
