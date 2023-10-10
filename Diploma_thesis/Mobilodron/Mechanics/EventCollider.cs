using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EventCollider : MonoBehaviour
{
    public bool triggered = false;
    public TypesOfRandomEvent typeOfEvent;

    private string loseText = "";
    public bool canWalk = false;

    public bool checkBlueColor = false;
    public bool checkRedColor = false;
    public bool checkYellowColor = false;

    public int checkSpeed = 0;

    public void setLoseText(string newText) {
        loseText = newText;
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.name == "Drone")
        {
            if (!triggered)
            {
                if (typeOfEvent != TypesOfRandomEvent.NONE) {
                    triggered = true;
                }

                if (typeOfEvent == TypesOfRandomEvent.DIRECTION) {
                    if (!canWalk)
                    {
                        MainGame.gameOverScreen(loseText);
                        return;
                    }
                } else if (typeOfEvent == TypesOfRandomEvent.COLOR) {
                    if (checkBlueColor) {
                        if (!MainGame.GetDroneVariables().isBlue()) {
                            MainGame.gameOverScreen(loseText);
                            return;
                        }
                    } else if (checkRedColor) {
                        if (!MainGame.GetDroneVariables().isRed()) {
                            MainGame.gameOverScreen(loseText);
                            return;
                        }
                    } else {
                        if (!MainGame.GetDroneVariables().isYellow()) {
                            MainGame.gameOverScreen(loseText);
                            return;
                        }
                    }
                } else if (typeOfEvent == TypesOfRandomEvent.SPEED) {
                    if (checkSpeed < MainGame.GetDroneVariables().getSpeed()) {
                        MainGame.gameOverScreen(loseText);
                        return;
                    }
                } else if (typeOfEvent == TypesOfRandomEvent.LIGHTS) {
                    if (!MainGame.GetDroneVariables().getLights()) {
                        MainGame.gameOverScreen(loseText);
                        return;
                    }
                }
            }
        }
    }

    public void restart() {
        typeOfEvent = TypesOfRandomEvent.NONE;
        triggered = false;
        checkBlueColor = false;
        checkRedColor = false;
        checkYellowColor = false;
        checkSpeed = 0;
        canWalk = false;
    }
}
