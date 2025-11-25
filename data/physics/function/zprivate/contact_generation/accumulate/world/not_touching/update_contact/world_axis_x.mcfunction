# Check if the contact should be discarded
# (Important): I can't check if the contact is still relevant, because there is no "current tick's contact normal" I could compare it to.
    # Calculate the Penetration Depth
    $execute if score #Physics.Contact.FeatureB Physics matches 10 run scoreboard players operation #Physics.PenetrationDepth Physics = #Physics.ThisObject Physics.Object.CornerPosGlobal.$(FeatureA).x
    execute if score #Physics.Contact.FeatureB Physics matches 10 run scoreboard players operation #Physics.PenetrationDepth Physics -= #Physics.Projection.Block.WorldAxis.x.Min Physics
    execute if score #Physics.Contact.FeatureB Physics matches 11 run scoreboard players operation #Physics.PenetrationDepth Physics = #Physics.Projection.Block.WorldAxis.x.Max Physics
    $execute if score #Physics.Contact.FeatureB Physics matches 11 run scoreboard players operation #Physics.PenetrationDepth Physics -= #Physics.ThisObject Physics.Object.CornerPosGlobal.$(FeatureA).x

    # Check if the Penetration Depth is within the threshold (Can be slightly negative)
    execute if score #Physics.PenetrationDepth Physics < #Physics.Settings.Accumulation.MinPenetrationDepth Physics run return 0

# Append the contact
$data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts append value {FeatureA:$(FeatureA)b}
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].FeatureB byte 1 run scoreboard players get #Physics.Contact.FeatureB Physics
