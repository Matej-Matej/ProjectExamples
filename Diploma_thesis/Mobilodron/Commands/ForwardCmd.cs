using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ForwardCmd : Command
{
    /*
     * Metoda pre prikaz DOPREDU
     */

    private int stepLength = 2; // dlzka kroku ( do buducna to moze byt kludne konstanta )
    void Start()
    {
        base.InitializeVariables();
    }

    // Prepisana metoda, ktora vykona potrebnu akciu prikazu
    public override void performAction(float time)
    {
        MainGame.GetDroneMovement().moveForward(stepLength,time);
    }
}
