using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class UpwardCmd : Command
{

    /*
    * Metoda pre prikaz VZLIETNUT HORE
    */
    private int stepLength = 1;

    void Start()
    {
        base.InitializeVariables();
    }

    public override void performAction(float time)
    {
        MainGame.GetDroneMovement().moveVertical(stepLength,time);
    }
}
