using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DroneVariables : MonoBehaviour
{
    private int speed;
    private int defSpeed;
    private bool lights;
    private bool defLights;
    private int color;
    private int defColor;

    public bool redrawnVariablesOnScreen = false;

    void Start()
    {
        defSpeed = speed;
        defLights = lights;
        defColor = 0;
        redrawnVariablesOnScreen = true;
    }

    public void restartVariables()
    {
        speed = defSpeed;
        lights = defLights;
        color = defColor;
        redrawnVariablesOnScreen = true;
    }

    public void setSpeed(int sp)
    {
        speed = sp;
        redrawnVariablesOnScreen = true;
    }
    public void setLights(bool li)
    {
        lights = li;
        MainGame.GetDroneMovement().turnLights(li);
        redrawnVariablesOnScreen = true;
    }

    public void setColor(Color col)
    {
        if (col == Color.red) 
        {
            color = 1;
            MainGame.GetDroneMovement().changeDroneColor.changeToRed();
        }
        else if (col == Color.yellow)
        {
            color = 2;
            MainGame.GetDroneMovement().changeDroneColor.changeToYellow();
        }
        else 
        {
            color = 3;
            MainGame.GetDroneMovement().changeDroneColor.changeToBlue();
        }
        redrawnVariablesOnScreen = true;
    }

    public void resetColor() 
    {
        color = 0;
        setLights(false);
        MainGame.GetDroneMovement().changeDroneColor.restartColor();
        redrawnVariablesOnScreen = true;
    }

    public int getSpeed() { return speed; }
    public bool getLights() { return lights; }
    public int getColor() { return color; }

    public bool isRed() { return color == 1;}
    public bool isBlue() { return color == 3;}
    public bool isYellow() { return color == 2;}

}
