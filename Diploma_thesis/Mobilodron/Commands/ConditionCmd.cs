using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ConditionCmd : Command
{

    void Start()
    {
        base.InitializeVariables();
        containContainer = true;
        commandType = TypesEnum.CONDITION;
    }
}
