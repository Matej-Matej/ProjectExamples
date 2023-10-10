using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DownwardCmd : Command
{
    /*
    * Metoda pre prikaz VZLIETNUT DOLE
    */
    private int stepLength = 1; 
    void Start()
    {
        base.InitializeVariables();
    }

    public override void performAction(float time)
    {
        MainGame.GetDroneMovement().moveVertical(-stepLength,time);
    }
}
