using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WhileLoopCmd : Command
{
    // Start is called before the first frame update
    void Start()
    {
        base.InitializeVariables();
        containContainer = true;
        commandType = TypesEnum.WHILE_LOOP;
    }
}
