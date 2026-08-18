extends State
class_name	InvestigateAI

## If the PLAYER enters the DETECTION AREA and is inside the FOV, start a small INVESTIGATION TIMER. If the INVESTIGATION TIMER reaches 0, increase the size of the FOV/DETECTION AREA and transition into a CHASE STATE. If the PLAYER exits the FOV, transition into the PATROL STATE
