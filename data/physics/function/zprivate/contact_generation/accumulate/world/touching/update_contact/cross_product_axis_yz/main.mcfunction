# (Important): All the "reject the contact entirely" checks have to be run before the "keep the contact but mark it as invalid" checks.

# Check if the contact is still relevant
# (Important): I project this contact's normal onto the current tick's contact's normal. If it's less than 70%, the contact is discarded completely for stability and performance reasons. If it's less than 90%, just carry over the contact without updating it (invalid contact).
scoreboard players operation #Physics.DotProduct Physics = #Physics.CrossProductAxis.yz.x Physics
scoreboard players operation #Physics.DotProduct Physics *= #Physics.ContactNormal.x Physics

scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.CrossProductAxis.yz.z Physics
scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ContactNormal.z Physics
scoreboard players operation #Physics.DotProduct Physics += #Physics.Maths.Value1 Physics

# Get the features
    # Edge A
    # (Important): Everything's cached, as there are only 4 possible values. So no "get_edge_a" function is necessary.
    $function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/cross_product_axis_yz/get_edge_a with storage physics:temp data.BlockEdge.$(FeatureA)

execute store success score #Physics.InvertValues Physics if score #Physics.Projection.Object.CrossProductAxis.yz.Min Physics = #Physics.PenetrationDepth Physics
execute if score #Physics.InvertValues Physics matches 1 run scoreboard players operation #Physics.DotProduct Physics *= #Physics.Constants.-1 Physics
execute if score #Physics.DotProduct Physics matches ..700000 run return 0

    # Edge B
    # (Important): To save scoreboard checks and to avoid further calculations if the contact is invalid anyway, the rest of the logic is performed in this function.
    execute if score #Physics.Contact.FeatureB Physics matches 24 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/cross_product_axis_yz/get_edge_b {Edge:24b,StartCorner:0b,x:"Min",y:"Min",z:"Min"}
    execute if score #Physics.Contact.FeatureB Physics matches 25 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/cross_product_axis_yz/get_edge_b {Edge:25b,StartCorner:1b,x:"Min",y:"Min",z:"Max"}
    execute if score #Physics.Contact.FeatureB Physics matches 26 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/cross_product_axis_yz/get_edge_b {Edge:26b,StartCorner:2b,x:"Max",y:"Min",z:"Min"}
    function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/cross_product_axis_yz/get_edge_b {Edge:27b,StartCorner:3b,x:"Max",y:"Min",z:"Max"}
