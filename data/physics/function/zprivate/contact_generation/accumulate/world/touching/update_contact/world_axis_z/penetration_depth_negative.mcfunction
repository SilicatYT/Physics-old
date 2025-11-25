# Append the contact
$data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts append value {FeatureA:$(FeatureA)b,ContactNormal:[I;0,0,1000]}
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].FeatureB byte 1 run scoreboard players get #Physics.Contact.FeatureB Physics

# Update the Penetration Depth
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].PenetrationDepth short 1 run scoreboard players get #Physics.PenetrationDepth Physics

# Update the Contact Normal
execute if score #Physics.Contact.FeatureB Physics matches 14 run data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactNormal[2] set value -1000
