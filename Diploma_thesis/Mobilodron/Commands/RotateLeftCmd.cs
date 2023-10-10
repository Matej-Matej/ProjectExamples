using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RotateLeftCmd : Command
{
    /*
    * Metoda pre prikaz OTOCENIE VLAVO
    */

    void Start()
    {
        base.InitializeVariables();
    }


    public override void performAction(float time)
    {
        MainGame.GetDroneMovement().rotate(-90,time);
    }
}
