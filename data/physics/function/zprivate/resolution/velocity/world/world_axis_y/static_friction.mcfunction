# Correct the scale of tangential impulses (They need to be 1,000x because I want to preserve accuracy if dynamic friction occurs)
scoreboard players operation #Physics.Maths.Impulse.x Physics = #Physics.Maths.ContactVelocity.x Physics
scoreboard players operation #Physics.Maths.Impulse.z Physics = #Physics.Maths.ContactVelocity.z Physics
scoreboard players operation #Physics.Maths.ContactVelocity.x Physics *= #Physics.Constants.1000 Physics
scoreboard players operation #Physics.Maths.ContactVelocity.z Physics *= #Physics.Constants.1000 Physics
