# Correct the scale of tangential impulses (They need to be 1,000x because I want to preserve accuracy if dynamic friction occurs)
scoreboard players operation #Physics.Maths.Impulse.y Physics = #Physics.Maths.ContactVelocity.y Physics
scoreboard players operation #Physics.Maths.Impulse.z Physics = #Physics.Maths.ContactVelocity.z Physics
scoreboard players operation #Physics.Maths.ContactVelocity.y Physics *= #Physics.Constants.1000 Physics
scoreboard players operation #Physics.Maths.ContactVelocity.z Physics *= #Physics.Constants.1000 Physics
