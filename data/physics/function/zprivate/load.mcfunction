# Init
scoreboard objectives add Physics dummy
execute unless score #Physics.Init Physics matches 1 run function physics:zprivate/init

# Summon root display entity
summon minecraft:block_display ~ ~ ~ {UUID:[I;0,0,0,0],Tags:["Physics.Root"]}

# Tellraw
#tellraw @a ["",{text:"Physics >> ",color:"#99EAD6"},{text:"Made by CMDred",click_event:{action:"open_url",url:"https://www.youtube.com/BluesProductionTeam"},hover_event:{action:"show_text",value:[{text:"YouTube: ",color:"dark_aqua"},{text:"CMDred",color:"white"}]}},"\n",{text:"Physics >> ",color:"#99EAD6"},"Get the latest updates: ",{text:"Modrinth",color:"#5491F7",click_event:{action:"open_url",url:"https://modrinth.com/datapack/placeholder"},hover_event:{action:"show_text",value:["Open page"]}},", ",{text:"GitHub",color:"#5491F7",click_event:{action:"open_url",url:"https://github.com/CMDred/Placeholder"},hover_event:{action:"show_text",value:["Open page"]}}]
tellraw @a ["",{text:"Physics >> ",color:"#99EAD6"},{text:"Made by SilicatYT",click_event:{action:"open_url",url:"https://www.youtube.com/BluesProductionTeam"},hover_event:{action:"show_text",value:[{text:"YouTube: ",color:"dark_aqua"},{text:"CMDred",color:"white"}]}},"\n",{text:"Physics >> ",color:"#99EAD6"},"PLACEHOLDER: ",{text:"Modrinth",color:"#5491F7",click_event:{action:"open_url",url:"https://modrinth.com/datapack/placeholder"},hover_event:{action:"show_text",value:["Open page"]}},", ",{text:"GitHub",color:"#5491F7",click_event:{action:"open_url",url:"https://github.com/SilicatYT/Physics"},hover_event:{action:"show_text",value:["Open page"]}}]
tellraw @a ["",{text:"Physics >> ",color:"#99EAD6"},{text:"(Additional credits)",hover_event:{action:"show_text",value:["- ",{text:"Triton365",color:"dark_aqua"}," (Fast Square Root)\n","- ",{text:"SethBling",color:"dark_aqua"}," (Inspiration & Help)"]}}]
tellraw @a ["",{text:"Physics >> ",color:"#99EAD6"},{text:"Click here to open the settings!",color:"yellow",click_event:{action:"run_command",command:"function physics:settings/open"},hover_event:{action:"show_text",value:["Click"]}}]
