# Project the block's center onto the object's axis
# (Important): This is done once per contact, although I could re-use the data for the block. But it's not guaranteed that such a contact exists that needs this, so it's better to do it here anyway.
scoreboard players operation #Physics.Projection.BlockCenter.ObjectAxis.x Physics = #Physics.BlockCenterPos.x Physics
scoreboard players operation #Physics.Projection.BlockCenter.ObjectAxis.x Physics *= #Physics.ThisObject Physics.Object.Axis.x.x

scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.BlockCenterPos.y Physics
scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.x.y
scoreboard players operation #Physics.Projection.BlockCenter.ObjectAxis.x Physics += #Physics.Maths.Value1 Physics

scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.BlockCenterPos.z Physics
scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.x.z
scoreboard players operation #Physics.Projection.BlockCenter.ObjectAxis.x Physics += #Physics.Maths.Value1 Physics

scoreboard players operation #Physics.Projection.BlockCenter.ObjectAxis.x Physics /= #Physics.Constants.1000 Physics

# Check if the contact should be discarded
    # Calculate the Penetration Depth
    $scoreboard players operation #Physics.PenetrationDepth Physics = #Physics.Projection.BlockCornerBase$(FeatureB).ObjectAxis.x Physics
    scoreboard players operation #Physics.PenetrationDepth Physics += #Physics.Projection.BlockCenter.ObjectAxis.x Physics
    execute if score #Physics.Contact.FeatureA Physics matches 10 run scoreboard players operation #Physics.PenetrationDepth Physics -= #Physics.ThisObject Physics.Object.ProjectionOwnAxis.x.Min
    execute if score #Physics.Contact.FeatureA Physics matches 11 run scoreboard players operation #Physics.PenetrationDepth Physics -= #Physics.ThisObject Physics.Object.ProjectionOwnAxis.x.Max
    execute if score #Physics.Contact.FeatureA Physics matches 11 run scoreboard players operation #Physics.PenetrationDepth Physics *= #Physics.Constants.-1 Physics

    # Check if the Penetration Depth is within the threshold (Can be slightly negative)
    execute if score #Physics.PenetrationDepth Physics < #Physics.Settings.Accumulation.MinPenetrationDepth Physics run return 0

# Append the contact
$data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts append value {FeatureB:$(FeatureB)b}
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].FeatureA byte 1 run scoreboard players get #Physics.Contact.FeatureA Physics
