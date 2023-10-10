using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PickCmd : Command
{
    // Start is called before the first frame update
    void Start()
    {
        base.InitializeVariables();
    }

    public override void performAction(float time)
    {
        MainGame.GetCargoDetector().setPickCargo(true);
    }
}
