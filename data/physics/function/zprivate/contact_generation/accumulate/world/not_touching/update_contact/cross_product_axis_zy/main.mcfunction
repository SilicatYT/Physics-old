# Get the features
    # Edge A
    $function physics:zprivate/contact_generation/accumulate/world/not_touching/update_contact/cross_product_axis_zy/get_edge_a with storage physics:temp data.BlockEdge.$(FeatureA)

execute store success score #Physics.InvertValues Physics if score #Physics.Projection.Object.CrossProductAxis.zy.Min Physics = #Physics.PenetrationDepth Physics

    # Edge B
    execute if score #Physics.Contact.FeatureB Physics matches 20 run return run function physics:zprivate/contact_generation/accumulate/world/not_touching/update_contact/cross_product_axis_zy/get_edge_b {Edge:28b,StartCorner:0b}
    execute if score #Physics.Contact.FeatureB Physics matches 21 run return run function physics:zprivate/contact_generation/accumulate/world/not_touching/update_contact/cross_product_axis_zy/get_edge_b {Edge:29b,StartCorner:2b}
    execute if score #Physics.Contact.FeatureB Physics matches 22 run return run function physics:zprivate/contact_generation/accumulate/world/not_touching/update_contact/cross_product_axis_zy/get_edge_b {Edge:30b,StartCorner:4b}
    function physics:zprivate/contact_generation/accumulate/world/not_touching/update_contact/cross_product_axis_zy/get_edge_b {Edge:31b,StartCorner:6b}
