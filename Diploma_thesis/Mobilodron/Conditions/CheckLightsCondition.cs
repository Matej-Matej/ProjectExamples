using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CheckLightsCondition : ConditionLeftSide
{
    // Start is called before the first frame update
    void Awake()
    {
        nameOfTheCondition = "Znacka: svetla";
        nameOfTheVariable = "Svetla";
        addMiddleCondition(ConditionMiddleEnum.EQUAL);
        addRightCondition(ConditionRightEnum.LIGHTS_TRUE);
        addRightCondition(ConditionRightEnum.LIGHTS_FALSE);
    }

    // Update is called once per frame
    void Update()
    {

    }

    public override string getNameOfTheCondition()
    {
        return base.getNameOfTheCondition();
    }

    public override string getNameOfTheVariable()
    {
        return base.getNameOfTheVariable();
    }

    public override List<ConditionMiddleEnum> GetConditionMiddleEnums()
    {
        return base.GetConditionMiddleEnums();
    }

    public override List<ConditionRightEnum> GetConditionRightEnums()
    {
        return base.GetConditionRightEnums();
    }

    public override void changeVariable(int rightIndex)
    {
        ConditionRightEnum rig = rightCondition[rightIndex];

        switch (rig)
        {
            case ConditionRightEnum.LIGHTS_TRUE:
                MainGame.GetDroneVariables().setLights(true);
                break;
            case ConditionRightEnum.LIGHTS_FALSE:
                MainGame.GetDroneVariables().setLights(false);
                break;
            default:
                break;
        }
    }

    public override bool evaluateCondition(int middleIndex, int rightIndex)
    {
        ConditionMiddleEnum mid = middleCondition[middleIndex];
        ConditionRightEnum rig = rightCondition[rightIndex];

        switch (rig)
        {
            case ConditionRightEnum.LIGHTS_FALSE:
                return MainGame.GetDroneVariables().getLights() == false;
            case ConditionRightEnum.LIGHTS_TRUE:
                return MainGame.GetDroneVariables().getLights() == true;
            default:
                break;
        }
        return false;
    }

}
