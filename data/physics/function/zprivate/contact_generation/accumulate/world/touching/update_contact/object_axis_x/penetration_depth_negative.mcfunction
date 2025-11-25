# Append contact
$data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts append value {FeatureB:$(FeatureB)b,ContactNormal:[I;0,0,0]}
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].FeatureA byte 1 run scoreboard players get #Physics.Contact.FeatureA Physics

# Penetration Depth
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].PenetrationDepth short 1 run scoreboard players get #Physics.PenetrationDepth Physics

# Contact Normal
execute if score #Physics.Contact.FeatureA Physics matches 10 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/object_axis_x/penetration_depth_negative_2 {ObjectAxis:"x"}
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactNormal[0] int 1 run scoreboard players get #Physics.ThisObject Physics.Object.Axis.x.x
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactNormal[1] int 1 run scoreboard players get #Physics.ThisObject Physics.Object.Axis.x.y
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactNormal[2] int 1 run scoreboard players get #Physics.ThisObject Physics.Object.Axis.x.z
