$scoreboard players set #Physics.Value Physics $(Value)
execute if score #Physics.Value Physics matches ..-1 run tellraw @s [{text:"Physics >> ",color:"#99EAD6"},{text:"The restitution threshold must not be below 0 (0.0 blocks/tick).",color:"red"}]
execute if score #Physics.Value Physics matches ..-1 at @s run return run playsound minecraft:entity.villager.no master @s ~ ~ ~
execute if score #Physics.Value Physics matches 250001.. run tellraw @s [{text:"Physics >> ",color:"#99EAD6"},{text:"The restitution threshold must not exceed 250000 (0.5 blocks/tick).",color:"red"}]
execute if score #Physics.Value Physics matches 250001.. at @s run return run playsound minecraft:entity.villager.no master @s ~ ~ ~

scoreboard players operation #Physics.Settings.Resolution.RestitutionThreshold Physics = #Physics.Value Physics
execute at @s run playsound minecraft:ui.button.click master @s ~ ~ ~
function physics:settings/open
