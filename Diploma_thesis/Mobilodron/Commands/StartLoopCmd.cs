using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class StartLoopCmd : Command
{

    public int numberOfLoops = 2;

    void Start()
    {
        base.InitializeVariables();
        containContainer = true;
        commandType = TypesEnum.LOOP;
    }

    public override int getNumberOfLoops()
    {
        return numberOfLoops;
    }
}
