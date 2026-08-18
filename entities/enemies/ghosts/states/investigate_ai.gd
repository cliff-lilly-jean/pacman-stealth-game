extends State
class_name	InvestigateAI

## The player enters the detection area, inside the fov
## If the player is visible and not obstructed by an obstacle, change the navigation target position to the player's last known position and travel to it
## If the player is visible and obstructed, continue on with the regular navigation route
