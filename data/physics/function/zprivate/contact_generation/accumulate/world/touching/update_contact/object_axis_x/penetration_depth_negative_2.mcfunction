# Contact Normal
$execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactNormal[0] int -1 run scoreboard players get #Physics.ThisObject Physics.Object.Axis.$(ObjectAxis).x
$execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactNormal[1] int -1 run scoreboard players get #Physics.ThisObject Physics.Object.Axis.$(ObjectAxis).y
$execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactNormal[2] int -1 run scoreboard players get #Physics.ThisObject Physics.Object.Axis.$(ObjectAxis).z
